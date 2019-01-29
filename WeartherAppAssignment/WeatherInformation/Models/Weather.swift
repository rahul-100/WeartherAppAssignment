//
//  Weather.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 27/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import Foundation
import SwiftyJSON

struct Weather {
    
    // MARK: - Properties
    
    var locality: String?
    var country: String?

    var date: String?
    var time: String?
    var description: String?
    var humidity: Double?
    var windSpeed: Double?

    var temperature: Temperature?
    var temperatureMin: Temperature?
    var temperatureMax: Temperature?
    
    var temperatureFah: Temperature?
    var temperatureFahMin: Temperature?
    var temperatureFahMax: Temperature?
    
    var forecastData: [WeatherForecast] = []
    
    // MARK: - init
    
    init(json: JSON) {
        initCurrentWeatherData(json: json)
        initWeatherForecastData(json: json)
    }
    
    private mutating func initCurrentWeatherData(json: JSON) {
        
        if let localityCountry = json["city"].dictionaryObject {
            locality = localityCountry["name"] as? String
            country = localityCountry["country"] as? String
        }
        
        if let currentWeather = json["list"][0].dictionaryObject {
            
            if let dt = currentWeather["dt"] as? Double {
                date = Date.weatherDate(dt)
                time = Date.weatherTime(dt)
            }
            
            if let currentWeatherInfo = currentWeather["main"] as? [String: Any] {
                
                if let temp = currentWeatherInfo["temp"] as? Double {
                    temperature = Temperature(tempInKelvin: temp)
                    temperatureFah = Temperature(tempInFah: temp)
                }
                
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
            
            if let wind = currentWeather["wind"] as? [String:Any] {
                if let windSpeed = wind["speed"] as? Double {
                    self.windSpeed = windSpeed
                }
            }
            
            if let currentWeatherDetail = currentWeather["weather"] as? [[String: Any]], currentWeatherDetail.count>0 {
                description = currentWeatherDetail[0]["description"] as? String
            }
            
        }
        
    }
    
    private mutating func initWeatherForecastData(json: JSON) {
        let jsonList = json["list"].arrayValue
        for index in 0...jsonList.count-1 {
            if index%8 == 0 {
                guard let weatherDictionary = jsonList[index].dictionaryObject else { return }
                let forecast = WeatherForecast(weatherDictionary: weatherDictionary)
                self.forecastData.append(forecast)
            }
        }
    }

}
