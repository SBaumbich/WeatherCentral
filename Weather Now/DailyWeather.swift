//
//  DailyWeather.swift
//  Weather Now
//
//  Created by Scott Baumbich on 11/4/15.
//  Copyright © 2015 Scott Baumbich. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather {
    
    let maxTemperature: Int?
    let minTemperature: Int?
    let humidity: Int?
    let precipChance: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    var largeIcon: UIImage? = UIImage(named: "default_large.png")
    var sunriseTime: String?
    var sunsetTime: String?
    var day: String?
    let dateFormatter = NSDateFormatter()
    
    
    init(dailyWeatherDict: [String:AnyObject]) {
    
        maxTemperature = dailyWeatherDict["temperatureMax"] as? Int
        minTemperature = dailyWeatherDict["temperatureMin"] as? Int
        if let humidityFloat = dailyWeatherDict["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)} else {humidity = nil}
        if let precipChancefloat = dailyWeatherDict["precipProbability"] as? Double {
            precipChance = Int(precipChancefloat * 100)} else {precipChance = nil}
        summary = dailyWeatherDict["summary"] as? String
        if let iconString = dailyWeatherDict["icon"] as? String, let iconEnum = Icon(rawValue: iconString) {
            (icon,largeIcon) = iconEnum.toImage()
        }
        if let sunriseDate = dailyWeatherDict["sunriseTime"] as? Double {
            sunriseTime = timeStringFromUnixTime(sunriseDate)
        } else {sunriseTime = nil}
        if let sunsetDate = dailyWeatherDict["sunsetTime"] as? Double {
            sunsetTime = timeStringFromUnixTime(sunsetDate)
        } else {sunsetTime = nil}
        if let time = dailyWeatherDict["time"] as? Double {
            day = dayStringFromUnixTime(time)
        }
    }
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        
        // returns date formated as 12hour time
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.stringFromDate(date)
    }
    
    func dayStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(date)
    }
}









