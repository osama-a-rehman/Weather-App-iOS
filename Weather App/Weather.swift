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
    
    func downloadWeatherData(){
        Alamofire.request(Utils.DEMO_WEATHER_URL).responseJSON { response in
    
            if let rootObj = response.result.value as? Dictionary<String, AnyObject> {
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
                        self._temperature = temp
                        /*print("Type: \(self._weatherType), Temp: \(self._temperature), City: \(self._city)")*/
                    }
                }
            }
        }
        
        // Call completed()
        
        print("Type: \(_weatherType), Temp: \(_temperature), City: \(_city)")
    }
    
}
