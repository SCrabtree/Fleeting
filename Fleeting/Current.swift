//  Current.swift
//
//  Fleeting
//  Created by Sean Crabtree on 3/08/15.
//  Copyright (c) 2015 Sean Crabtree. All rights reserved.

import Foundation
import UIKit

struct Current {
    
    var temperature: Int
    var summary: String
    var sunriseTime: String?
    var sunsetTime: String?

//    var threeHourTemp: Int
//    var sixHourTemp: Int
//    var nineHourTemp: Int
//
//    var threeHourTime: String?
//    var sixHourTime: String?
//    var nineHourTime: String?
    
    init(weatherDictionary: NSDictionary) {
        
        //CURRENT WEATHER
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        temperature = currentWeather["apparentTemperature"] as Int
        summary = currentWeather["summary"] as String
        
        
//        //HOURLY WEATHER
//        let hourlyWeather = weatherDictionary["hourly"] as NSDictionary
//        threeHourTemp = hourlyWeather["apparentTemperature"] as Int
//        sixHourTemp = hourlyWeather["apparentTemperature"] as Int
//        nineHourTemp = hourlyWeather["apparentTemperature"] as Int
//        
//        
//        //HOURLY TIME
//        let hourlyTime = weatherDictionary["hourly"] as NSDictionary
//        let hourlySummary = hourlyTime["summary"] as String
//        let hourlyDataArray = hourlyTime["data"] as NSArray
//        let hourlyData = hourlyDataArray.lastObject as NSDictionary
//        
//        // 3-Hour Time
//        let threeHourTimeIntValue = hourlyData["time"] as Int
//        threeHourTime = dateStringFromUnixTime(threeHourTimeIntValue) as String
//        
//        // 6-Hour Time
//        let sixHourTimeIntValue = hourlyData["time"] as Int
//        sixHourTime = dateStringFromUnixTime(sixHourTimeIntValue) as String
//        
//        // 9-Hour Time
//        let nineHourTimeIntValue = hourlyData["time"] as Int
//        nineHourTime = dateStringFromUnixTime(nineHourTimeIntValue) as String

        
        //DAILY WEATHER
        let dailyWeather = weatherDictionary["daily"] as NSDictionary
        let dailySummary = dailyWeather["summary"] as String
        let dailyDataArray = dailyWeather["data"] as NSArray
        let dailyData = dailyDataArray.lastObject as NSDictionary

        let sunriseTimeIntValue = dailyData["sunriseTime"] as Int
        sunriseTime = dateStringFromUnixTime(sunriseTimeIntValue) as String
        let sunsetTimeIntValue = dailyData["sunsetTime"] as Int
        sunsetTime = dateStringFromUnixTime(sunsetTimeIntValue)
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
}