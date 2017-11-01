//
//  Weather.swift
//  Weather App
//
//  Created by Osama Mac on 10/30/17.
//  Copyright © 2017 Osama Mac. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    private var _date: String!
    private var _temperature: Double!
    private var _city: String!
    private var _weatherType: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var temperature: Double {
        if _temperature == nil {
            _temperature = 0.0
        }
        
        return _temperature
    }
    
    var city: String {
        if _city == nil {
            _city = ""
        }
        
        return _city
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    func downloadWeatherData(completed: @escaping DownloadComplete){
        Alamofire.request(Utils.DEMO_WEATHER_URL).responseJSON { response in
    
            /*if let rootObj = response.result.value as? Dictionary<String, AnyObject> {
                if let weatherArray = rootObj["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weatherArray[0]["main"] as? String {
                        self._weatherType = main
                    }
                }
                
                if let name = rootObj["name"] as? String {
                    self._city = name
                }
                
                if let main = rootObj["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double {
                        var celsius = temp - 273
                        celsius = Double(round(100 * celsius)/100)
                        
                        self._temperature = celsius
                        
                    }
                }
            }*/
            
            if let rootObj = response.result.value as? Dictionary<String, AnyObject> {
                
                if let location = rootObj["location"] as? Dictionary<String, AnyObject> {
                    if let tz_id = location["tz_id"] as? String {
                        self._city = tz_id.components(separatedBy: "/")[1]
                    }
                
                }

                
                if let current = rootObj["current"] as? Dictionary<String, AnyObject> {
                    if let temp = current["temp_c"] as? Double {
                        var celsius = temp
                        celsius = Double(round(100 * celsius)/100)
                        
                        self._temperature = celsius
                    }
                    
                    if let condition = current["condition"] as? Dictionary<String, AnyObject> {
                        if let type = condition["text"] as? String {
                            self._weatherType = type
                        }
                    }
                }
            }
            
            if let error = response.error {
                print(error)
            }
            
            print("Type: \(self.weatherType), Temp: \(self.temperature), City: \(self.city), Date: \(self.date)")
            
            completed()
        }
    }
    
}
