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
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    var didFetchWeatherData: ((Result<WeatherData, WeatherDataError>) -> Void)?
    
    private let locationService: LocationService
    
    init(locationService: LocationService) {
        self.locationService = locationService
        
        fetchWeatherData(for: Defaults.location)
        
        fetchLocation()
    }
    
    // MARK: - Helper Methods
    
    private func fetchLocation() {
        locationService.fetchLocation { [weak self] (result) in
            switch result {
            case .success(let location):
                // Fetch Weather Data
                self?.fetchWeatherData(for: location)
            case .failure(let error):
                print("Unable to Fetch Location (\(error))")
                
                // Invoke Completion Handler
                self?.didFetchWeatherData?(.failure(.notAuthorizedToRequestLocation))
            }
        }
    }
    
    private func fetchWeatherData(for location: Location) {
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: location)

        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let error = error {
                print("error \(error)")
                self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
            } else if let data = data {
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .secondsSince1970
                
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
