//
//  WeekDayViewModel.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/18/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit

struct WeekDayViewModel {
    
    // MARK: - Properties
    
    let weatherData: ForecastWeatherConditions
    
    // MARK: -
    
    private let dateFormatter = DateFormatter()

    // MARK: -
    
    var day: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var date: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var temperature: String {
        // the temperature we got from darksky is Fahrenheit, but we use Celsius in China
        let celsiusMinTemperature = (weatherData.temperatureMin - 32.0) * 5.0 / 9.0
        let celsiusMaxTemperature = (weatherData.temperatureMax - 32.0) * 5.0 / 9.0
        let min = String(format: "%.1f °C", celsiusMinTemperature)
        let max = String(format: "%.1f °C", celsiusMaxTemperature)
        
        return "\(min) - \(max)"
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }

}

extension WeekDayViewModel: WeekDayRepresentable {
    
}

