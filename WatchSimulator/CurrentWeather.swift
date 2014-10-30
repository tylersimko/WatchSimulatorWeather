//
//  CurrentWeather.swift
//
//  Created by Tyler Simko on 10/27/14.
//  Copyright (c) 2014 O8 Labs. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    
    var currentTime: String?
    var temperature: Int
    var summary: String
    
    init(weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        temperature = currentWeather["temperature"] as Int
               summary = currentWeather["summary"] as String
        let currentTimeIntValue = currentWeather["time"] as Int
        currentTime = dateStringFromUnixTime(currentTimeIntValue)
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
}