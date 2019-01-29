//
//  WeatherForecastTableViewCell.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 28/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    // MARK: - Type Properties
    
    static let reuseIdentifier = "ForecastCell"
    
    // MARK: - Properties
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configuration
    
    func configureWeatherForecast(_ forecast: WeatherForecast, isFah: Bool) {
        
        self.dateTimeLabel.text = "\(forecast.date ?? "")"

        if isFah == true {
            if let tempMin = forecast.temperatureFahMin?.fah {
                self.temperatureMinLabel.text = "Min:  \(tempMin)"
            }
            if let tempMax = forecast.temperatureFahMax?.fah {
                self.temperatureMaxLabel.text = "Max:  \(tempMax)"
            }
        }else {
            if let tempMin = forecast.temperatureMin?.degrees {
                self.temperatureMinLabel.text = "Min:  \(tempMin)"
            }
            if let tempMax = forecast.temperatureMax?.degrees {
                self.temperatureMaxLabel.text = "Max:  \(tempMax)"
            }
        }
        
        if let humidity = forecast.humidity {
            self.humidityLabel.text = "Humidity:  \(humidity)"
        }
        if let windSpeed = forecast.windSpeed {
            self.windLabel.text = "Wind:  \(String(format: "%.2f", windSpeed))" + " m/sec"
        }
        
    }

}
