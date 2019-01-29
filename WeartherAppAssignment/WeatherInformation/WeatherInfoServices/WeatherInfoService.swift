//
//  WeatherInfoService.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 28/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import Foundation
import CoreLocation
import SwiftyJSON

enum WeatherServiceError: Error {
    case unknown
    case urlError
    case failedRequest
    case invalidResponse
}

typealias WeatherServiceCompletionHandler = (JSON?, WeatherServiceError?) -> Void


final class WeatherInfoService {
    
    fileprivate let baseURL = "http://api.openweathermap.org/data/2.5/"
    
    fileprivate let subURL5DaysForecast = "forecast"//5-days forecast:
    fileprivate let subURLTodaysForecast = "weather" //Today’s forecast:

    // MARK: - Public
    
    func request5DaysWeatherForecast(lat: String, lon: String, completionHandler: @escaping WeatherServiceCompletionHandler) {
        
        // Create request URL
        guard let requestURL = createRequestURL(baseURL: baseURL+subURL5DaysForecast, lat: lat, lon: lon) else {
            completionHandler(nil, .urlError)
            return
        }
        print(requestURL)
        
        // Create Data Task
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async {
                self.processWeatherData(data: data, response: response, error: error,
                                        completion: completionHandler)
            }
        }.resume()
        
    }
    
    func requestTodaysWeatherForecast(lat: String, lon: String, completionHandler: @escaping WeatherServiceCompletionHandler) {
        
        // Create request URL
        guard let requestURL = createRequestURL(baseURL: baseURL+subURLTodaysForecast, lat: lat, lon: lon) else {
            completionHandler(nil, .urlError)
            return
        }
        print(requestURL)
        
        // Create Data Task
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async {
                self.processWeatherData(data: data, response: response, error: error,
                                        completion: completionHandler)
            }
            }.resume()
        
    }
    
    // MARK: - Private
    
    private func createRequestURL(baseURL : String, lat: String, lon: String) -> URL? {
        
        guard var components = URLComponents(string:baseURL) else {
            return nil
        }
        
        let appId = getOWMAppId()
        
        components.queryItems = [URLQueryItem(name:klat, value:lat),
                                 URLQueryItem(name:klon, value:lon),
                                 URLQueryItem(name:"appid", value:appId),
        ]
        
        return components.url
        
    }
    
    private func processWeatherData(data: Data?, response: URLResponse?, error: Error?,
                                    completion: WeatherServiceCompletionHandler) {
        
        if let _ = error {
            completion(nil, .failedRequest)
        }
        else if let data = data, let response = response as? HTTPURLResponse {
            
            if response.statusCode == 200 {
                do {
                    // Decode JSON
                    let json = try JSON(data: data)
                    completion(json, nil)
                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        }
        else {
            completion(nil, .unknown)
        }
    }
    
    // MARK: - Helper Methods
    
    func getOWMAppId() -> String {
        // get OpenWeatherMap App Id from Info.plist
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let parameters = NSDictionary(contentsOfFile:filePath)
        let appId = (parameters!["OWMAppId"]! as! String).trimmingCharacters(in: .whitespacesAndNewlines)
        return appId
    }
    
}
