//
//  WeekyTableViewController.swift
//  Weather Now
//
//  Created by Scott Baumbich on 11/3/15.
//  Copyright © 2015 Scott Baumbich. All rights reserved.
//x

import UIKit
import CoreLocation

class WeekyTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    private let forecastAPIKey = "d09f58fa74cec6a14e3cac8201d420a3"
    var coordinate: (lat: Double, long: Double) = (41.8369, -87.6847){
        didSet{
            retrieveWeatherForecast()
            refreshControl?.endRefreshing()
        }
    }
    var weeklyWeather: [DailyWeather] = []
    
    @IBOutlet var currentWeatherTemprature: UILabel!
    @IBOutlet var currentWeatherIcon: UIImageView!
    @IBOutlet var currentWeatherPrecipitation: UILabel!
    @IBOutlet var currentTempratureRange: UILabel!
    @IBOutlet var currentWeatherLocation: NSLayoutConstraint!
    @IBOutlet var currentLocationLable: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
 
        configureView()
        retrieveWeatherForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshWeather() {
        retrieveWeatherForecast()
        refreshControl?.endRefreshing()
    }
    
    
    // MARK: - Navigation Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDaily" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dailyWeather = weeklyWeather[indexPath.row]
                
                //let destVC = segue.destinationViewController as! ViewController
                (segue.destinationViewController as! ViewController).dailyWeather = dailyWeather
                (segue.destinationViewController as! ViewController).locationName = currentLocationLable.text as String!
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "7-Day Forecast"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! DailyWeatherTableViewCell
        
        let dailyWeather = weeklyWeather[indexPath.row]
        if let maxTemp = dailyWeather.maxTemperature {
            cell.temperatureLable.text = "\(maxTemp)º"
        }
        cell.dayLable.text = dailyWeather.day
        cell.weatherIcon.image = dailyWeather.icon
        
        return cell

    }
    
    func configureView() {
        
        // Set tableview's background view prop
        tableView.backgroundView = BackgroundView()
        
        // Set table view's background view property
        tableView.rowHeight = 64
        
        // Change the font and size of nav bar text
        if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
        
            let navBarAttributesDictionary: [String:AnyObject]? = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: navBarFont]
            
            navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        }
        
        // Position refresh control above background view
        refreshControl?.layer.zPosition = tableView.backgroundView!.layer.zPosition + 1
        refreshControl?.tintColor = UIColor.whiteColor()
        
        
    }
    
    // MARK: - Delegate Methods
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 16/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 14.0)
            
            header.textLabel?.textColor = UIColor.whiteColor()
        }
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor(red: 16/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor(red: 16/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
        cell?.selectedBackgroundView = highlightView
    }
    
    
    // MARK: - Location Settings
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        let userLat = Double(userLocation.coordinate.latitude)
        let userLong = Double(userLocation.coordinate.longitude)
        coordinate = (userLat,userLong)
        print(coordinate)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            if error != nil {
                print(error)
            } else {
                let place = placemarks?.first
                let city = place?.locality != nil ? place?.locality : ""
                let state = place?.administrativeArea != nil ? place?.administrativeArea : ""
                self.currentLocationLable.text = "\(city!), \(state!)"
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    
    // MARK: - Weather Fetching
    
    func retrieveWeatherForecast() {
        
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) { (forecast) -> Void in
            if let weatherForecast = forecast,
            let currentWeather = weatherForecast.currentWeather {
                // Update UI
                dispatch_async(dispatch_get_main_queue()) {
                    // Execute closure
                    if let temperature = currentWeather.temperature {
                        self.currentWeatherTemprature?.text = "\(temperature)º"
                    } else { print("Error: Could not update UI with current Temp")}
                    if let precipitation = currentWeather.precipProbability {
                        self.currentWeatherPrecipitation?.text = "Rain: \(precipitation)%"
                    } else { print("Error: Could not update UI with precipitation")}
                    if let icon  = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    } else { print("Error: Could not update UI with weather icon")}
                    
                    self.weeklyWeather = weatherForecast.weekly
                    
                    if let highTemp = self.weeklyWeather.first?.maxTemperature,
                        let lowTemp = self.weeklyWeather.first?.minTemperature {
                            self.currentTempratureRange?.text = "↑\(highTemp)º↓\(lowTemp)º"
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }    
}
