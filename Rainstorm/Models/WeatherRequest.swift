//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/14/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    
    let baseUrl: URL
    let location: CLLocation
    
    private var latitude: Double {
        return location.coordinate.latitude
    }
    
    private var longitude: Double {
        return location.coordinate.longitude
    }
    
    var url: URL {
        return baseUrl.appendingPathComponent("\(latitude), \(longitude)")
    }
    
}

