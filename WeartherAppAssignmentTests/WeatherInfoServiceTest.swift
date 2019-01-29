//
//  WeatherInfoServiceTest.swift
//  WeartherAppAssignmentTests
//
//  Created by Rahul Parashar on 30/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//

import XCTest

class WeatherInfoServiceTest: XCTestCase {

    var weatherInfoService:WeatherInfoService?
    
    override func setUp() {
        self.weatherInfoService = WeatherInfoService()
    }
    
    func testWeatherInfoServiceCreation(){
        XCTAssertNotNil(self.weatherInfoService)
    }

    func testGetOWMAppId() {
        XCTAssertNotNil(self.weatherInfoService?.getOWMAppId())
    }
    
    override func tearDown() {
        self.weatherInfoService = nil
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
