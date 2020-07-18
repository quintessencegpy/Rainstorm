//
//  WeekDayRepresentable.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/18/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit

protocol WeekDayRepresentable {
    
    var day: String { get }
    var date: String { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var image: UIImage? { get }
    
}
