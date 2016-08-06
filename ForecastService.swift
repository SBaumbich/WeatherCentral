//
//  ForecastService.swift
//  Weather Now
//
//  Created by Scott Baumbich on 11/2/15.
//  Copyright © 2015 Scott Baumbich. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    
    init (APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    
    }
    
    func getForecast(lat: Double, long: Double, completion: (Forecast? -> Void)) {
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL) {
            
            let networkOpperation = NetworkOperation(url: forecastURL)
            networkOpperation.downloadJSONFromURL {
                (JSONDictionary) -> Void in
                let forecast = Forecast(weatherDictionary: JSONDictionary)
                completion(forecast)
                
            }
        }
        else{
            print("Could not construct a valid URL")
        }
    }
}





