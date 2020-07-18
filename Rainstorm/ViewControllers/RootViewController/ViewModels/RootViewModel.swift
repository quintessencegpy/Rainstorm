//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/14/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit

class RootViewModel {
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    var didFetchWeatherData: ((Result<WeatherData, WeatherDataError>) -> Void)?
    
    private let locationService: LocationService
    private let networkService: NetworkService
    
    init(networkService: NetworkService, locationService: LocationService) {
        self.networkService = networkService
        self.locationService = locationService
        
        fetchWeatherData(for: Defaults.location)
        
        fetchLocation()
        
        setupNotificationHandling()
    }
    
    // MARK: - Public API
    
    func refresh() {
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
                DispatchQueue.main.async {
                    self?.didFetchWeatherData?(.failure(.notAuthorizedToRequestLocation))
                }
            }
        }
    }
    
    private func fetchWeatherData(for location: Location) {
        // Initialize Weather Request
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: location)
        
        // Fetch Weather Data
        networkService.fetchData(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to Fetch Weather Data \(error)")
                    
                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                    
                    // Configure JSON Decoder
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        // Decode JSON Response
                        let darkSkyResponse = try decoder.decode(DarkSkyResponse.self, from: data)
                        
                        // Update User Defaults
                        UserDefaults.didFetchWeatherData = Date()
                        
                        // Invoke Completion Handler
                        self?.didFetchWeatherData?(.success(darkSkyResponse))
                    } catch {
                        print("Unable to Decode JSON Response \(error)")
                        
                        // Invoke Completion Handler
                        self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                    }
                } else {
                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                }
            }
        }
    }
    
    // MARK: -
    
    private func setupNotificationHandling() {
        // Application Will Enter Foreground
 
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            guard let didFetchWeatherData = UserDefaults.didFetchWeatherData else {
                self?.refresh()
                return
            }
            
            if Date().timeIntervalSince(didFetchWeatherData) > Configuration.refreshThreshold {
                self?.refresh()
            }
        }
    }
}

extension UserDefaults {
    
    // MARK: - Types
    
    private enum Keys {
        static let didFetchWeatherData = "didFetchWeatherData"
    }
    
    // MARK: - Class Computed Properties
    
    fileprivate class var didFetchWeatherData: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.didFetchWeatherData) as? Date
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.didFetchWeatherData)
        }
    }
    
}
