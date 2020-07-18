//
//  DarkSkyResponse.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/14/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation

struct DarkSkyResponse: Codable {
    
    struct Conditions: Codable {
        let time: Date
        let icon: String
        let summary: String
        let windSpeed: Double
        let temperature: Double
    }
    
    struct Daily: Codable {
        
        struct Conditions: Codable {
            let time: Date
            let icon: String
            let windSpeed: Double
            let temperatureMin: Double
            let temperatureMax: Double
        }
        
        let data: [Conditions]
    }
        
    let latitude: Double
    let longitude: Double
    
    let daily: Daily
    let currently: Conditions
    
}

extension DarkSkyResponse: WeatherData {
    
    var current: CurrentWeatherConditions {
        return currently
    }
    
    var forecast: [ForecastWeatherConditions] {
        return daily.data
    }
    
}

extension DarkSkyResponse.Conditions: CurrentWeatherConditions {}

extension DarkSkyResponse.Daily.Conditions: ForecastWeatherConditions {}
