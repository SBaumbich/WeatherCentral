//
//  CurrentWeather.swift
//  Weather Now
//
//  Created by Scott Baumbich on 11/1/15.
//  Copyright © 2015 Scott Baumbich. All rights reserved.
//

import Foundation
import UIKit


struct CurrentWeather {

    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")


    init(weatherdictionary: [String: AnyObject]) {
    
        temperature = weatherdictionary["temperature"] as? Int
        if let humidityFloat = weatherdictionary["humidity"] as? Float{
            humidity = Int(humidityFloat * 100)
        } else { humidity = nil}
        if let precipProbabilityFloat = weatherdictionary["precipProbability"] as? Float{
            precipProbability = Int(precipProbabilityFloat * 100)
        } else {precipProbability = nil}
        summary = weatherdictionary["summary"] as? String
        if let iconString = weatherdictionary["icon"] as? String,
            let weatherIcon: Icon = Icon(rawValue: iconString) {
                (icon, _) = weatherIcon.toImage()
        }
    }
}







