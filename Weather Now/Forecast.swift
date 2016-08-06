//
//  Forecast.swift
//  Weather Now
//
//  Created by Scott Baumbich on 11/4/15.
//  Copyright © 2015 Scott Baumbich. All rights reserved.
//

import Foundation

struct Forecast {
    
    var currentWeather: CurrentWeather?
    var weekly: [DailyWeather] = []
    
    init(weatherDictionary: [String: AnyObject]?){
        if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String:AnyObject] {
            currentWeather = CurrentWeather(weatherdictionary: currentWeatherDictionary)
        }
        if let weeklyWeatherDictionary = weatherDictionary?["daily"]?["data"] as? [[String:AnyObject]] {
            
            for dailyWeather in weeklyWeatherDictionary {
                let daily = DailyWeather(dailyWeatherDict: dailyWeather)
                weekly.append(daily)
            }
        
        }
        
    }
}