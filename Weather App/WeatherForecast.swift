//
//  WeatherForecast.swift
//  Weather App
//
//  Created by Osama Mac on 10/31/17.
//  Copyright © 2017 Osama Mac. All rights reserved.
//

import Foundation
import Alamofire

class WeatherForecast{
    private var _day: String!
    private var _weatherType: String!
    private var _minTemp: Double!
    private var _maxTemp: Double!
    
    var day: String {
        if _day == nil {
            _day = ""
        }
        
        return _day
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var minTemp: Double {
        if _minTemp == nil {
            _minTemp = 0.0
        }
        
        return _minTemp
    }
    
    var maxTemp: Double {
        if _maxTemp == nil {
            _maxTemp = 0.0
        }
        
        return _maxTemp
    }
    
    init(forecastItem: Dictionary<String, AnyObject>) {
        // APUXI
        
        if let date_epoch = forecastItem["date_epoch"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date_epoch)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._day = unixConvertedDate.dayOfWeek()
        }
        
        if let day = forecastItem["day"] as? Dictionary<String, AnyObject> {
            if let min = day["mintemp_c"] as? Double {
                var celsius = min
                celsius = Double(round(100 * celsius)/100)
                
                self._minTemp = celsius
            }
            
            if let max = day["maxtemp_c"] as? Double {
                var celsius = max
                celsius = Double(round(100 * celsius)/100)
                
                self._maxTemp = celsius
            }
            
            if let condition = day["condition"] as? Dictionary<String, AnyObject> {
                if let type = condition["text"] as? String {
                    self._weatherType = type
                }
            }
        }
    }
    
    func fillInfo (forecastItem: Dictionary<String, AnyObject>) {
        /*if let main = forecastItem["main"] as? Dictionary<String, AnyObject> {
            if let min = main["temp_min"] as? Double {
                var celsius = min - 273
                celsius = Double(round(100 * celsius)/100)
                
                self._minTemp = celsius
            }
            
            if let max = main["temp_max"] as? Double {
                var celsius = max - 273
                celsius = Double(round(100 * celsius)/100)
                
                self._maxTemp = celsius
            }
        }
        
        if let weather = forecastItem["weather"] as? [Dictionary<String, AnyObject>] {
            if let type = weather[0]["main"] as? String {
                self._weatherType = type
            }
        }
        
        if let dt = forecastItem["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: dt)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._day = unixConvertedDate.dayOfWeek()
            
        }
        
        print("Type: \(self.weatherType), Min-Temp: \(self.minTemp), Max-Temp: \(self.maxTemp), Day: \(self.day)")*/
        
        
        // APUXI
        
        if let date_epoch = forecastItem["date_epoch"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date_epoch)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._day = unixConvertedDate.dayOfWeek()
        }
        
        if let day = forecastItem["day"] as? Dictionary<String, AnyObject> {
            if let min = day["mintemp_c"] as? Double {
                var celsius = min
                celsius = Double(round(100 * celsius)/100)
                
                self._minTemp = celsius
            }
            
            if let max = day["maxtemp_c"] as? Double {
                var celsius = max
                celsius = Double(round(100 * celsius)/100)
                
                self._maxTemp = celsius
            }
            
            if let condition = day["condition"] as? Dictionary<String, AnyObject> {
                if let type = condition["text"] as? String {
                    self._weatherType = type
                }
            }
        }
    }
}

extension Date{
    func dayOfWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
