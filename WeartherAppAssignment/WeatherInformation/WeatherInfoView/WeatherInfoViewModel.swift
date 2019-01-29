//
//  WeatherInfoViewModel.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 28/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import Foundation
import CoreLocation

class WeatherInfoViewModel {
    
    // MARK: - Properties
    
    fileprivate lazy var weatherService = {
        return WeatherInfoService()
    }()
    
    let errorMessage: WeatherObserver<String?>
    let weatherInfo: WeatherObserver<Weather?>
    
    // MARK: - init
    
    init() {
        errorMessage = WeatherObserver(nil)
        weatherInfo = WeatherObserver(nil)
    }
    
    // MARK: - public
    
    func requestWeatherInfo(lat:String, lon:String) {
        
        weatherService.request5DaysWeatherForecast(lat: lat, lon: lon) { (json, error) in
            DispatchQueue.main.async(execute: {
                
                if let error = error {
                    self.updateViewModelWithError(error)
                    return
                }
                
                guard let json = json else { return }
                
                let weatherInfo: Weather = Weather(json: json)
                self.updateViewModelWithWeatherInfo(weatherInfo)
                
            })
        }
        
    }
    
    // MARK: - private
    
    private func updateViewModelWithError(_ error: WeatherServiceError) {
        
        switch error {
        case .unknown:
            self.errorMessage.value = "Something went wrong!"
        case .urlError:
            self.errorMessage.value = "The weather service is not working!"
        case .failedRequest:
            self.errorMessage.value = "Network appears to be down. Try again later!"
        case .invalidResponse:
            self.errorMessage.value = "We're having trouble processing weather data!"
        }
        
        self.weatherInfo.value = nil
        
    }
    
    private func updateViewModelWithWeatherInfo(_ weather: Weather) {
        self.errorMessage.value = nil
        self.weatherInfo.value = weather
    }
}
