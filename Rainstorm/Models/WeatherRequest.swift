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
    let location: Location
    
    private var latitude: Double {
        return location.latitude
    }
    
    private var longitude: Double {
        return location.longitude
    }
    
    var url: URL {
        return baseUrl.appendingPathComponent("\(latitude), \(longitude)")
    }
    
}

