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
    var icon: UIImage?
    
    init(weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        temperature = currentWeather["temperature"] as Int
        summary = currentWeather["summary"] as String
    }
}