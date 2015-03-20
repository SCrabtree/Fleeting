//  ViewController.swift
//
//  Fleeting
//  Created by Sean Crabtree on 3/08/15.
//  Copyright (c) 2015 Sean Crabtree. All rights reserved.

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    let defaultLatitude: Double = 37.30925
    let defaultLongitude: Double = -122.0436444
    
    var allowLocation: Bool = false
    var seenError: Bool = false
    var locationFixAchieved: Bool = false
    var locationStatus: NSString = "Not Started"
    var locationManager: CLLocationManager!
    var userLocation: String!
    var userLatitude: Double!
    var userLongitude: Double!
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var mainArt: UIImageView!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var sunsetTime: UILabel!
    @IBOutlet weak var locationName: UILabel!

    
    let apiKey = "d7539a30efd5669aa702bdce4a2e1436"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocationManager()
        initArtwork()
    }
    
    // LOCATION
    
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Override CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            if (!seenError) {
                seenError = true
                print(error)
            }
        }
    }
    
    // Override CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if (!locationFixAchieved) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as CLLocation
            var coord = locationObj.coordinate
            
            self.userLatitude = coord.latitude
            self.userLongitude = coord.longitude
            
            getCurrentWeatherData()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.allowLocation = false
        
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = "Location access is restricted"
        case CLAuthorizationStatus.Denied:
            locationStatus = "Location access is denied"
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = "Location access is not determined"
        default:
            locationStatus = "Location access is allowed"
            self.allowLocation = true
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if (self.allowLocation == true) {
            NSLog("Location is allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
            self.userLatitude = self.defaultLatitude
            self.userLongitude = self.defaultLongitude
            getCurrentWeatherData()
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.locationName.text = self.allowLocation ? "Now" : "Cupertino, CA"
        })
    }
    
    // WEATHER
    
    func getCurrentWeatherData() -> Void {
        
        userLocation = "\(userLatitude),\(userLongitude)"
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        let forecastURL = NSURL(string: "\(userLocation)", relativeToURL: baseURL)
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if (error == nil) {
                
                let dataObject = NSData(contentsOfURL: location)
                let weatherDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                
                let currentWeather = Current(weatherDictionary: weatherDictionary)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.temperatureLabel.text = "\(currentWeather.temperature)"
                    self.summaryLabel.text = "\(currentWeather.summary)"
                    self.sunriseTime.text = "\(currentWeather.sunriseTime!)"
                    self.sunsetTime.text = "\(currentWeather.sunsetTime!)"
                })
            } else {
                
                let networkIssueController = UIAlertController(title: "Error", message: "Unable to load data. Connectivity error!", preferredStyle: .Alert)
                
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                networkIssueController.addAction(okButton)
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                networkIssueController.addAction(cancelButton)
                
                self.presentViewController(networkIssueController, animated: true, completion: nil)

                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //Stop refresh animation
                    self.refreshActivityIndicator.stopAnimating()
                    self.refreshActivityIndicator.hidden = true
                    self.refreshButton.hidden = false
                })
            }
        })
        
        downloadTask.resume()
    }
    
    func initArtwork() {
        let r = Int(arc4random())
        let artId = r % 13 + 1;
        let artIdString = "\(artId)"
        self.mainArt.image = UIImage(named: artIdString)
    }

}

