//
//  WeatherObserver.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 27/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//

import Foundation


/// A struct representing value change event.
public struct Value<T> {
    
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
    
}

public final class WeatherObserver<T> {
    
    typealias WeatherObserver = (T) -> Void
    
    var observer: WeatherObserver?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observe(_ observer: WeatherObserver?) {
        self.observer = observer
        observer?(value)
    }
}
