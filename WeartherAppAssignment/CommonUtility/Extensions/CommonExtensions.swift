//
//  CommonExtensions.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 27/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//

import Foundation
import UIKit

// MARK: - String Helper Methods

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String {
    var isValidNonEmptyString: String? {
        if let unwrapped = self {
            return unwrapped.isBlank ? nil: unwrapped
        } else {
            return nil
        }
    }
}

extension UserDefaults {
    
    class func bool(forKey key: String) -> Bool {
        return self.standard.bool(forKey: key)
    }
    
    class func setBool(value: Bool, forKey key: String) {
        self.standard.set(value, forKey: key)
    }
    
    class func setObject(object: Any, forKey key: String) {
        if let data:Data = NSKeyedArchiver.archivedData(withRootObject: object) as Data? {
            self.standard.set(data, forKey: key)
            self.standard.synchronize()
        }
        
    }
    
    class func getObject(forKey key: String) -> Any? {
        if let data = self.standard.object(forKey: key) as? Data {
            if let object:AnyObject = NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject? {
                return object
            }
        }
        return nil
    }
}

extension UIViewController {
    func showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Weather App", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Date {
    
    static func weatherDate(_ dt: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE dd"
        let date = Date(timeIntervalSince1970: dt)
        return dateFormatter.string(from: date)
    }
    
    static func weatherTime(_ dt: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a"
        let date = Date(timeIntervalSince1970: dt)
        return dateFormatter.string(from: date)
    }
}
