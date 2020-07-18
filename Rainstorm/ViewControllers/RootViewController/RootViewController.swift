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

    enum AlertType {
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    private let viewModel: RootViewModel
    
    // MARK: - View Controllers
    
    private let dayViewController: DayViewController = DayViewController()
    
    private let weekViewController: WeekViewController = WeekViewController()
    
    // MARK: - View Life Cycle
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupChildViewControllers()
        setupViewModel()
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
    
    private func setupViewModel() {
        viewModel.didFetchWeatherData = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    let dayViewModel = DayViewModel(weatherData: weatherData.current)
                    
                    self?.dayViewController.viewModel = dayViewModel
                    
                    let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                    
                    self?.weekViewController.viewModel = weekViewModel
                case .failure:
                    self?.presentAlert(of: .noWeatherDataAvailable)
                }
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        let title: String
        let message: String
        
        switch alertType {
        case .noWeatherDataAvailable:
            title = "noWeatherDataAvailable"
            message = "noWeatherDataAvailable"
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
}

extension RootViewController {
    
    fileprivate enum Layout {
        enum DayView {
            static let height: CGFloat = 200
        }
    }
    
}
