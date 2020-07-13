//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/11/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit

final class WeekViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: WeekViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    // MARK: - Factory Method
    
    static func create(withViewModel viewModel: WeekViewModel) -> WeekViewController {
        let vc = WeekViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .red
    }
    
    private func setupViewModel() {
        
    }
    
}
