//
//  Utils.swift
//  Weather App
//
//  Created by Osama Mac on 10/30/17.
//  Copyright © 2017 Osama Mac. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

class Utils {
    public static let BASE_URL = "https://api.apixu.com/v1/"
    public static let URL_TYPE_CURRENT = "current.json?"
    public static let URL_TYPE_FORECAST = "forecast.json?"
    public static let APP_ID = "key="
    public static let QUERY = "&q="
    public static let DAYS = "&days="
    
    // APIXU.com
    public static let API_KEY = "31627029231141f6997182643170111"
    
    public static let DEMO_WEATHER_URL = "\(BASE_URL)\(URL_TYPE_CURRENT)\(APP_ID)\(API_KEY)\(QUERY)55,%2022"
    
    public static let DEMO_FORECAST_URL = "\(BASE_URL)\(URL_TYPE_FORECAST)\(APP_ID)\(API_KEY)\(QUERY)55,%2022\(DAYS)8"
    
    // My Location 24.820834, 66.983454
}
