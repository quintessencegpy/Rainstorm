//
//  MockLocationService.swift
//  RainstormTests
//
//  Created by Pengyu Gou on 7/19/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation
@testable import Rainstorm

class MockLocationService: LocationService {
    
    // MARK: - Properties
    
    var location: Location? = Location(latitude: 0.0, longitude: 0.0)

    // MARK: -
    
    var delay: TimeInterval = 0.0

    // MARK: - Location Service
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        // Create Result
        var result: Result<Location, LocationServiceError>

        if let location = location {
            result = .success(location)
        } else {
            result = .failure(.notAuthorizedToRequestLocation)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // Invoke Handler
            completion(result)
        }
    }

}
