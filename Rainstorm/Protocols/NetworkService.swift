//
//  NetworkService.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/19/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    // MARK: - Type Aliases
    
    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: - Methods
    
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion)
    
}
