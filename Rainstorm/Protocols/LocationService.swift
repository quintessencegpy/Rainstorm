//
//  LocationService.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/18/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation

enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    
    // MARK: - Type Aliases
    
    typealias FetchLocationCompletion = (Result<Location, LocationServiceError>) -> Void
    
    // MARK: - Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
    
}
