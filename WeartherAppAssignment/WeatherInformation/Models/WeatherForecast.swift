//
//  WeatherForecast.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 27/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import Foundation

struct WeatherForecast {
    
    // MARK: - Properties

    var date: String?
    var time: String?
    var description: String?
    var humidity: Double?
    var windSpeed: Double?
    var temperatureMin: Temperature?
    var temperatureMax: Temperature?
    
    var temperatureFahMin: Temperature?
    var temperatureFahMax: Temperature?
    
    // MARK: - init
    
    init(weatherDictionary: [String: Any]) {
        
        if let dt = weatherDictionary["dt"] as? Double {
            date = Date.weatherDate(dt)
            time = Date.weatherTime(dt)
        }
        
        if let currentWeatherInfo = weatherDictionary["main"] as? [String: Any] {
            
            if let tempMin = currentWeatherInfo["temp_min"] as? Double {
                temperatureMin = Temperature(tempInKelvin: tempMin)
                temperatureFahMin = Temperature(tempInFah: tempMin)
            }
            
            if let tempMax = currentWeatherInfo["temp_max"] as? Double {
                temperatureMax = Temperature(tempInKelvin: tempMax)
                temperatureFahMax = Temperature(tempInFah: tempMax)
            }
            
            if let humidity = currentWeatherInfo["humidity"] as? Double{
                self.humidity =  humidity
            }
        }
        
        if let wind = weatherDictionary["wind"] as? [String:Any] {
            if let windSpeed = wind["speed"] as? Double {
                self.windSpeed = windSpeed
            }
        }
        
        if let currentWeatherDetail = weatherDictionary["weather"] as? [[String: Any]], currentWeatherDetail.count>0 {
            description = currentWeatherDetail[0]["description"] as? String
        }
        
    }
    
}
