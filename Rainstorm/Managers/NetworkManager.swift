//
//  NetworkManager.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/19/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation

class NetworkManager: NetworkService {
    
    // MARK: - Network Service
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
    
}
