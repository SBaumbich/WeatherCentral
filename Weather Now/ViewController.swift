//
//  ViewController.swift
//  Weather Now
//
//  Created by Scott Baumbich on 11/1/15.
//  Copyright © 2015 Scott Baumbich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Property Observer
    var dailyWeather: DailyWeather? {
        didSet{
            configureView()
        }
    }
    var locationName: String?
    
    @IBOutlet var weatherIcon: UIImageView?
    @IBOutlet var summaryLable: UILabel?
    @IBOutlet var sunriseTimeLable: UILabel?
    @IBOutlet var sunsetTimeLable: UILabel?
    @IBOutlet var lowTempLable: UILabel?
    @IBOutlet var highTempLable: UILabel?
    @IBOutlet var rainLable: UILabel?
    @IBOutlet var humidityLable: UILabel?
    @IBOutlet var locationNameLable: UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        if let locName = locationName {
            locationNameLable?.text = locName
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    func configureView() {
        if let weather = dailyWeather {
            
            // Configure UI with info from data model
            weatherIcon?.image = weather.largeIcon
            summaryLable?.text = weather.summary
            sunriseTimeLable?.text = weather.sunriseTime
            sunsetTimeLable?.text = weather.sunsetTime
            self.title = weather.day
            
            if let lowTemp = weather.minTemperature,
            let hightTemp = weather.maxTemperature,
            let rain = weather.precipChance,
            let humidity = weather.humidity {
            
                lowTempLable?.text = "\(lowTemp)º"
                highTempLable?.text = "\(hightTemp)º"
                rainLable?.text = "\(rain)%"
                humidityLable?.text = "\(humidity)%"
            }
        }
        

        
        // Config Nav back button
        if let barButton = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            
            let barButtonAttributesDictionary: [String:AnyObject]? = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: barButton]
            
                UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
        }
    }
    
    func showAlertBoxWithOK(title:String, message:String, OkButtonText:String, viewController:UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: OkButtonText, style: UIAlertActionStyle.Default)
            { action -> Void in
                return
            })
        viewController.presentViewController(alertController, animated: true, completion: {
            return
        })
    }
}










