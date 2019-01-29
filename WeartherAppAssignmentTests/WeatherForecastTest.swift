//
//  WeatherForecastTest.swift
//  WeartherAppAssignmentTests
//
//  Created by Rahul Parashar on 29/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//

import XCTest

class WeatherForecastTest: XCTestCase {

    var weatherForecast:WeatherForecast?
    var weatherForecastNil:WeatherForecast?
    
    
    override func setUp() {
        self.weatherForecast = WeatherForecast(weatherDictionary: ["wind":["deg":303.503,"speed":3.74],"dt_txt":"2019-01-28 21:00:00","dt":1548709200,"sys":["pod":"n"],"clouds":["all":0],"main":["temp_kf":0,"temp_min":280.447,"humidity":70.0,"sea_level":1034.84,"temp":280.45,"pressure":1014.55,"grnd_level":1014.55,"temp_max":280.45],"weather":[["icon":"01n","id":800,"main":"Clear","description":"clear sky"]]])
        
        self.weatherForecastNil = WeatherForecast(weatherDictionary: ["wind":["deg":303.503,"speed":nil],"dt_txt":"2019-01-28 21:00:00","dt":1548709200,"sys":["pod":"n"],"clouds":["all":0],"main":["temp_kf":0,"temp_min":nil,"humidity":nil,"sea_level":1034.84,"temp":280.45,"pressure":1014.55,"grnd_level":1014.55,"temp_max":nil],"weather":[["icon":"01n","id":800,"main":"Clear","description":"rain"]]])
        
    }
    
    func testWeatherForecastCreation(){
        XCTAssertNotNil(self.weatherForecast)
        XCTAssertNotNil(self.weatherForecastNil)
    }
    
    func testDescription(){
        XCTAssertEqual(self.weatherForecast?.description!, "clear sky")
    }
    
    func testDescriptionDataMismatch(){
        XCTAssertNotEqual(self.weatherForecastNil?.description!, "clear sky")
    }
    
    func testWindSpeed(){
        XCTAssertNotNil(self.weatherForecast?.windSpeed!, "Wind not nil")
    }
    
    func testWindSpeedNil(){
        XCTAssertNil(self.weatherForecastNil?.windSpeed, "Wind found nil")
    }
    
    func testHumidity(){
        XCTAssertNotNil(self.weatherForecast?.humidity!, "Humidity not nil")
    }
    
    func testHumidityNil(){
        XCTAssertNil(self.weatherForecastNil?.humidity, "Humidity found nil")
    }
    
    func testMaximumTemperature(){
        XCTAssertNotNil(self.weatherForecast?.temperatureMax!, "Maximum Temperature not nil")
    }
    
    func testMaximumTemperatureNil(){
        XCTAssertNil(self.weatherForecastNil?.temperatureMax, "Maximum Temperature found nil")
    }
    
    func testMinimumTemperature(){
        XCTAssertNotNil(self.weatherForecast?.temperatureMin!, "Minimum Temperature not nil")
    }
    
    func testMinimumTemperatureNil(){
        XCTAssertNil(self.weatherForecastNil?.temperatureMin, "Minimum Temperature found nil")
    }
    
    
    override func tearDown() {
        self.weatherForecast = nil
        self.weatherForecastNil = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
