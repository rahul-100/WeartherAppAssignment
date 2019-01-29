//
//  Temperature.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 27/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import Foundation

struct Temperature {
    
    var degrees: String?
    var fah: String?

    init(tempInKelvin: Double?) {
        if let temp = tempInKelvin {
            // Since OWM api returns Temperature in Kelvin by default, need to convert it to celsius
            degrees = String(Temperature.kelvinToCelsius(temp)) + "\u{00B0}C"
        }
    }
    
    init(tempInFah: Double?) {
        if let temp = tempInFah {
            fah = String(Temperature.kelvinToFahrenheit(temp)) + "°F"
        }
    }
    
    static func kelvinToCelsius(_ degrees: Double) -> Int {
        return Int(round(degrees - 273.15))
    }
    
    static func kelvinToFahrenheit(_ degrees: Double) -> Int {
        return Int(round(degrees * 9 / 5 - 459.67))
    }
    
    static func celciusToFahrenheit(_ degrees: Double) -> Int {
        return Int(round(degrees * 9 / 5 + 32))
        
    }
    
    static func FahrenheitToCelsius(_ degrees: Double) -> Int {
        return Int(round(5.0 / 9.0 * (Double(degrees) - 32.0)))
    }
    
}
