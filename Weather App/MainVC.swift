//
//  MainVC.swift
//  Weather App
//
//  Created by Osama Mac on 10/30/17.
//  Copyright © 2017 Osama Mac. All rights reserved.
//

import UIKit
//import Alamofire

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var weather: Weather!

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    
    @IBOutlet weak var weatherForecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*Alamofire.request("http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=7635bed1828db2af91c7b9c91cc11f69").responseJSON{
            
            response in
            
            print(response.result.value)
        
        }*/
        
        weather = Weather()
        
        weather.downloadWeatherData {
            self.updateUI()
        }
        
        weatherForecastTableView.dataSource = self
        weatherForecastTableView.delegate = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherForecastCell {
            return cell
        }else{
            return WeatherForecastCell()
        }
    }
    
    func updateUI(){
        dateLabel.text = weather.date
        temperatureLabel.text = "\(weather.temperature)°"
        cityLabel.text = weather.city
        weatherTypeLabel.text = weather.weatherType
        
        weatherImage.image = UIImage(named: weather.weatherType)
    }

}

