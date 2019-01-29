//
//  WeatherInfoViewController.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 28/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import UIKit
import CoreLocation

class WeatherInfoViewController: UIViewController {
    
    // MARK: - Properties
    var isFlag : Bool = false
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var locationDict : [String:Any]?
    
    // MARK: - View Model
    
    var viewModel: WeatherInfoViewModel? {
        didSet {
            
            viewModel?.errorMessage.observe { (value) in
                if value != nil {
                    self.activityIndicatorView.stopAnimating()
                    self.showAlert(withMessage: value!)
                }
            }
            
            viewModel?.weatherInfo.observe({ (value) in
                if value != nil {
                    self.updateWeatherView(value!)
                }
            })
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        title = "City"
        self.locationLabel.text = locationDict?[kcity] as? String ?? ""
        forecastTableView.separatorInset = UIEdgeInsets.zero
        forecastTableView.tableFooterView = UIView()

        setupViewModel()
        activityIndicatorView.startAnimating()
        
        self.createBarButton()
        self.setupTodaysViewLayout()
    }
    
    
    // MARK: - Bar Button Selector
    
    @objc func addTapped() {
       
        if(isFlag == true){
                // Celcius:-
            isFlag = false
            
            if let temp = viewModel?.weatherInfo.value?.temperature?.degrees{
                self.temperatureLabel.text = temp
            }
            if let tempMin = viewModel?.weatherInfo.value?.temperatureMin?.degrees {
                self.temperatureMinLabel.text = "Min Temp:  \(tempMin)"
            }
            if let tempMax = viewModel?.weatherInfo.value?.temperatureMax?.degrees {
                self.temperatureMaxLabel.text = "Max Temp:  \(tempMax)"
            }
        }else {
                // Fahrenheit: -
            isFlag = true
            
            if let temp = viewModel?.weatherInfo.value?.temperatureFah?.fah{
                self.temperatureLabel.text = temp
            }
            if let tempMin = viewModel?.weatherInfo.value?.temperatureFahMin?.fah {
                self.temperatureMinLabel.text = "Min Temp:  \(tempMin)"
            }
            if let tempMax = viewModel?.weatherInfo.value?.temperatureFahMax?.fah {
                self.temperatureMaxLabel.text = "Max Temp:  \(tempMax)"
            }
        }
        
        self.forecastTableView.reloadData()
    }
    
    // MARK: - View Methods
    
    private func createBarButton() {
        let setting = UIBarButtonItem(title: "°C/°F", style: .plain, target: self, action: #selector(addTapped))
        setting.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [setting]
    }
    
    private func setupTodaysViewLayout() {
        self.weatherView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        self.weatherView.layer.cornerRadius = 20.0
    }
    
    private func setupViewModel() {
        viewModel = WeatherInfoViewModel()
        viewModel?.requestWeatherInfo(lat: String(locationDict?[klat] as? Double ?? 0), lon: String(locationDict?[klon] as? Double ?? 0))
    }
    
    private func updateWeatherView(_ weather: Weather) {
        
        self.activityIndicatorView.stopAnimating()
        self.weatherView.isHidden = false
        
        if self.isFlag == true {
            self.temperatureLabel.text = weather.temperature?.fah
        }else {
            self.temperatureLabel.text = weather.temperature?.degrees
        }
            
        if let tempMin = weather.temperatureMin?.degrees {
            self.temperatureMinLabel.text = "Min Temp:  \(tempMin)"
        }
        if let tempMax = weather.temperatureMax?.degrees {
            self.temperatureMaxLabel.text = "Max Temp:  \(tempMax)"
        }
        if let humidity = weather.humidity {
            self.humidityLabel.text = "Humidity:  \(humidity)"
        }
        if let windSpeed = weather.windSpeed {
            self.windLabel.text = "Wind:  \(String(format: "%.2f", windSpeed))" + " m/sec"
        }

        
        self.descriptionLabel.text = weather.description?.capitalized
        self.dateLabel.text = "\(weather.date ?? ""), \(weather.time ?? "")"

        forecastTableView.reloadData()
    }
    
}


    // MARK: - Tableview Delegate Methods

extension WeatherInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecastData = viewModel?.weatherInfo.value?.forecastData else { return 0 }
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastTableViewCell.reuseIdentifier, for: indexPath) as? WeatherForecastTableViewCell else { fatalError("Unexpected Table View Cell") }
        
        if let forecastData = viewModel?.weatherInfo.value?.forecastData {
            cell.configureWeatherForecast(forecastData[indexPath.row], isFah: isFlag)
        }

        return cell
    }
    
}
