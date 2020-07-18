//
//  QuickSpecExtension.swift
//  RainstormTests
//
//  Created by Pengyu Gou on 7/18/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import Quick
import Nimble

extension QuickSpec {
    
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
    
}
