//  Current.swift
//
//  Fleeting
//  Created by Sean Crabtree on 2/04/15.
//  Copyright (c) 2014 Sean Crabtree. All rights reserved.

import Foundation
import UIKit

struct Current {
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage?
    // var moonPhase: UIImage?
    
    init(weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        precipProbability = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        
        let currentTimeIntValue = currentWeather["time"] as Int
        currentTime = dateStringFromUnixTime(currentTimeIntValue)
        
//        let iconString = currentWeather["icon"] as String
//        icon = weatherIconFromString(iconString)
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    /* MOON PHASES
    
    func moonPhaseIconFromInt(intIcon: Int) -> UIImage {
    var imageName: String
    
    switch intIcon {
    case 0:
    imageName = "moon-new"
    case 0.25:
    imageName = "moon-first-quarter"
    case 0.5:
    imageName = "moon-full"
    case 0.75:
    imageName = "moon-last-quarter"
    default:
    imageName = "default"
    }
    
    var iconImage = UIImage(named: imageName)
    return iconImage!
    }
    */
    /*
    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        
        switch stringIcon {
        case "Clear":
            imageName = "clear-day"
        case "clear-night":
            imageName = "clear-night"
        case "rain":
            imageName = "rain"
        case "snow":
            imageName = "snow"
        case "sleet":
            imageName = "sleet"
        case "wind":
            imageName = "wind"
        case "fog":
            imageName = "fog"
        case "cloudy":
            imageName = "cloudy"
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "default"
        }
        
        var iconImage = UIImage(named: imageName)
        return iconImage!
    }
    */
    
}