//
//  RootViewController.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/11/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit
import SnapKit

class RootViewController: UIViewController {
    
    // MARK: - View Controllers
    
    private let dayViewController: DayViewController = DayViewController()
    
    private let weekViewController: WeekViewController = WeekViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupChildViewControllers()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupChildViewControllers() {
        addChild(dayViewController)
        addChild(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        dayViewController.view.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Layout.DayView.height)
        }
        
        weekViewController.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(dayViewController.view.snp.bottom)
        }
        
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
}

extension RootViewController {
    
    fileprivate enum Layout {
        enum DayView {
            static let height: CGFloat = 200
        }
    }
    
}
