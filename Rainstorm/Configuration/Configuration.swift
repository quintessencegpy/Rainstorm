//
//  Configuration.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/14/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation
import CoreLocation

enum Defaults {
    
    static let location = CLLocation(latitude: 37.335114, longitude: -122.008928)

}

enum WeatherService {
    
    private static let apiKey = "b3db279166b4b1b1f4b6f85fdfc62d3e"
    private static let baseUrl = URL(string: "https://api.darksky.net/forecast/")!
    
    static var authenticatedBaseUrl: URL {
        return baseUrl.appendingPathComponent(apiKey)
    }
}
