//
//  DayViewModel.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/14/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit

struct DayViewModel {
   
    // MARK: - Properties
    
    let weatherData: CurrentWeatherConditions
    
    // MARK: -
    
    private let dateFormatter = DateFormatter()
    
    // MARK: -
    
    var date: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEE, MMMM d YYYY"
        
        // Convert Date to String
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "hh:mm a"
        
        // Convert Date to String
        return dateFormatter.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        // the temperature we got from darksky is Fahrenheit, but we use Celsius in China
        let celsiusTemperature = (weatherData.temperature - 32.0) * 5.0 / 9.0
        return String(format: "%.1f °C", celsiusTemperature)
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
    
}
