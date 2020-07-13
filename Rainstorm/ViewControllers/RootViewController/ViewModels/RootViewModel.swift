//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/14/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation

class RootViewModel {
    
    enum WeatherDataError: Error {
        case noWeatherDataAvailable
    }
    
    var didFetchWeatherData: ((Result<WeatherData, WeatherDataError>) -> Void)?
    
    init() {
        fetchWeatherData()
    }
    
    private func fetchWeatherData() {
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)

        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let error = error {
                print("error \(error)")
                self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                    
                    self?.didFetchWeatherData?(.success(darkSkyResponse))
                } catch {
                    
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))

                }
            } else {
                
                self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                
            }
        }.resume()
    }
    
}

