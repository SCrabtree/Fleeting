//  Current.swift
//
//  Fleeting
//  Created by Sean Crabtree on 3/08/15.
//  Copyright (c) 2015 Sean Crabtree. All rights reserved.

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
}
/*
struct ArtWork {
    
    let artworkArray = [
        
        
        
        
        
    ]
        
    func randomArt() -> Image {
        // var randomNumber = Int(arc4random_uniform(UInt32(factsArray.count)))
            
        var unsignedArrayCount = UInt32(artworkArray.count)
        var unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        var randomNumber = Int(unsignedRandomNumber)
        
        return artworkArray[randomNumber]
    }
}
*/








/* IMAGE PER WEATHER TYPE
    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        
        switch stringIcon {
        case "clear":
            imageName = "clear-day"
        case "clear-night":
            imageName = "clear-night"
        case "rain":
            imageName = "rain-snow"
        case "snow":
            imageName = "snow"
        case "sleet":
            imageName = "cloudy-sleet"
        case "wind":
            imageName = "wind-fog"
        case "fog":
            imageName = "wind-fog"
        case "cloudy":
            imageName = "cloudy-sleet"
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        case "hail":
            imageName = "hail-thunderstorm-tornado"
        case "thunderstorm":
            imageName = "hail-thunderstorm-tornado"
        case "tornado":
            imageName = "hail-thunderstorm-tornado"
        default:
            imageName = "default"
        }
    
        var iconImage = UIImage(named: imageName)
        return iconImage!
    }   */