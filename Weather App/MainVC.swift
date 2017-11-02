//
//  MainVC.swift
//  Weather App
//
//  Created by Osama Mac on 10/30/17.
//  Copyright © 2017 Osama Mac. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var weather: Weather!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    
    @IBOutlet weak var weatherForecastTableView: UITableView!
    
    var forecastArray: [WeatherForecast]!
    var currentLocation: CLLocation!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weather = Weather()
        forecastArray = [WeatherForecast]()
        
        weatherForecastTableView.dataSource = self
        weatherForecastTableView.delegate = self
        
        locationManager.delegate = self
        /*locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()*/
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show Detailed Forecast
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherForecastCell {
            cell.configureCell(forecast: forecastArray[indexPath.row])
            
            return cell
        }else{
            return WeatherForecastCell()
        }
    }
    
    func updateUI(){
        dateLabel.text = weather.date
        temperatureLabel.text = "\(weather.temperature)°C"
        cityLabel.text = weather.city
        weatherTypeLabel.text = weather.weatherType
        
        weatherImage.image = weather.weatherImage
    }
    
    func downloadWeatherForecastData(completed: @escaping DownloadComplete){
        /*Alamofire.request(Utils.DEMO_FORECAST_URL).responseJSON { response in
            /*print(response.result.value)
            print("Error: \(response.error)")*/
            
            if let rootObj = response.result.value as? Dictionary<String, AnyObject> {
                if let list = rootObj["list"] as? [Dictionary<String, AnyObject>] {
                    for forecastItem in list {
                        self.forecast.fillInfo(forecastItem: forecastItem)
                        
                        print("Type: \(self.forecast.weatherType), Min-Temp: \(self.forecast.minTemp), Max-Temp: \(self.forecast.maxTemp), Day: \(self.forecast.day)")
                        
                        self.forecastArray.append(self.forecast)
                    }
                }else{
                    print("List Wrong")
                }
            }else{
                print("Root Wrong")
            }
            
            //print("Type: \(self.weatherType), Min-Temp: \(self._minTemp), Max-Temp: \(self.maxTemp), Day: \(self.day)")
            
            completed()
        }*/
        
        Alamofire.request(Utils.DEMO_FORECAST_URL).responseJSON { response in
            if let rootObj = response.result.value as? Dictionary<String, AnyObject> {
                if let forecastDict = rootObj["forecast"] as? Dictionary<String, AnyObject> {
                    if let forecastDaysArray = forecastDict["forecastday"] as? [Dictionary<String, AnyObject>] {
                        for forecastDay in forecastDaysArray {
                            self.forecastArray.append(WeatherForecast(forecastItem: forecastDay))
                            
                            //print("Type: \(self.forecast.weatherType), Min-Temp: \(self.forecast.minTemp), Max-Temp: \(self.forecast.maxTemp), Day: \(self.forecast.day)")
                        }
                    }else{
                        print("forecastDaysArray Wrong")
                    }
                }else{
                    print("forecastDict Wrong")
                }
            }else{
                print("Root Wrong")
            }
            
            //print("Type: \(self.weatherType), Min-Temp: \(self._minTemp), Max-Temp: \(self.maxTemp), Day: \(self.day)")
            
            completed()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            // Do your thing here
            
            currentLocation = locationManager.location
            
            Utils.latitude = currentLocation.coordinate.latitude
            Utils.longitude = currentLocation.coordinate.longitude
            
            Utils.DEMO_WEATHER_URL = "\(Utils.BASE_URL)\(Utils.URL_TYPE_CURRENT)\(Utils.APP_ID)\(Utils.API_KEY)\(Utils.QUERY)\(Utils.latitude!),%20\(Utils.longitude!)"
            
            Utils.DEMO_FORECAST_URL = "\(Utils.BASE_URL)\(Utils.URL_TYPE_FORECAST)\(Utils.APP_ID)\(Utils.API_KEY)\(Utils.QUERY)\(Utils.latitude!),%20\(Utils.longitude!)\(Utils.DAYS)\(Utils.NUM_OF_DAYS)"
            
            print("Utils.DEMO_WEATHER_URL: \(Utils.DEMO_WEATHER_URL)")
            print("Utils.DEMO_FORECAST_URL: \(Utils.DEMO_FORECAST_URL)")
            
            weather.downloadWeatherData {
                self.updateUI()
            
                self.downloadWeatherForecastData {
                    self.forecastArray.removeFirst()
                
                    self.weatherForecastTableView.reloadData()
                }
            }
            
        case .denied:
            // Permission denied, do something else
            locationManager.requestWhenInUseAuthorization()
            
        default: break
        }
    }
    
    /*func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
        }else{
            locationManager.requestWhenInUseAuthorization()
            //locationAuthStatus()
        }
    }*/
}

