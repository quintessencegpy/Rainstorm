//
//  MockNetworkService.swift
//  RainstormTests
//
//  Created by Pengyu Gou on 7/19/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation
@testable import Rainstorm

class MockNetworkService: NetworkService {
    
    // MARK: - Properties
    
    var data: Data?
    var error: Error?
    var statusCode: Int = 200
 
    // MARK: - Network Service
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        // Create Response
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        // Invoke Handler
        completionHandler(data, response, error)
    }
    
}
