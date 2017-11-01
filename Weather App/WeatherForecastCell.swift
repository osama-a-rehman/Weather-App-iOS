//
//  WeatherForecastCell.swift
//  Weather App
//
//  Created by Osama Mac on 10/30/17.
//  Copyright © 2017 Osama Mac. All rights reserved.
//

import UIKit

class WeatherForecastCell: UITableViewCell {
    
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastDaylabel: UILabel!
    @IBOutlet weak var forecastMaxTempLabel: UILabel!
    @IBOutlet weak var forecastWeatherTypeLabel: UILabel!
    @IBOutlet weak var forecastMinTempLabel: UILabel!
    
    func configureCell(forecast: WeatherForecast){
        forecastDaylabel.text = forecast.day
        forecastMaxTempLabel.text = "\(forecast.maxTemp)°C"
        forecastWeatherTypeLabel.text = forecast.weatherType
        forecastMinTempLabel.text = "\(forecast.minTemp)°C"
        
        forecastImage.image = UIImage(named: forecast.weatherType)        
    }
}
