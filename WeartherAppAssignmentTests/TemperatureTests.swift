//
//  TemperatureTests.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 29/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//

import XCTest

class TemperatureTests: XCTestCase {
    
    var tempInCelcius:Temperature?
    var tempInFahrenheit:Temperature?

    override func setUp() {

        self.tempInCelcius = Temperature(tempInKelvin: 32)
        self.tempInFahrenheit = Temperature(tempInFah: 32)
    }
    
    func testTemperatureCreation(){
        XCTAssertNotNil(self.tempInCelcius)
        XCTAssertNotNil(self.tempInFahrenheit)
    }
    
    func testTempInCelcius(){
        XCTAssertNotNil(self.tempInCelcius?.degrees!, "Temperature in celcius not nil")
    }
    
    func testTempInFahrenheit(){
        XCTAssertNotNil(self.tempInFahrenheit?.fah!, "Temperature in fahrenheit not nil")
    }
    
    func testTempInCelciusAccuracy(){
        XCTAssertEqual(self.tempInCelcius?.degrees!, "-241°C")
    }
    
    func testTempInFahrenheitAccuracy(){
        XCTAssertEqual(self.tempInFahrenheit?.fah!, "-402°F")
    }
    
    override func tearDown() {
        self.tempInCelcius = nil
        self.tempInFahrenheit = nil
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
