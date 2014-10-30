//
//  Current.swift
//  Stormy
//
//  Created by Tyler Simko on 10/27/14.
//  Copyright (c) 2014 O8 Labs. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipitationProbability: Double
    var summary: String
    var icon: UIImage?
    
    init(weatherDictionary: NSDictionary) {
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        precipitationProbability = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        let currentTimeIntValue = currentWeather["time"] as Int
        currentTime = dateStringFromUnixTime(currentTimeIntValue)
        let iconString = currentWeather["icon"] as String
        icon = weatherIconFromString(iconString)
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        switch stringIcon {
        case "clear-day":
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
    
}