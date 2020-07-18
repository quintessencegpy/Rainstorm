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

    // MARK: - Types
    
    private enum AlertType {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    private let viewModel: RootViewModel
    
    // MARK: - View Controllers
    
    private lazy var dayViewController: DayViewController = DayViewController()
    
    private lazy var weekViewController: WeekViewController = {
        let vc = WeekViewController()
        vc.delegate = self
        return vc
    }()
    
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
        // Configure View Model
        viewModel.didFetchWeatherData = { [weak self] (result) in
            switch result {
            case .success(let weatherData):
                // Initialize Day View Model
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                
                // Update Day View Controller
                self?.dayViewController.viewModel = dayViewModel
                
                // Initialize Week View Model
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                
                // Update Week View Controller
                self?.weekViewController.viewModel = weekViewModel
            case .failure(let error):
                let alertType: AlertType
                
                switch error {
                case .notAuthorizedToRequestLocation:
                    alertType = .notAuthorizedToRequestLocation
                case .failedToRequestLocation:
                    alertType = .failedToRequestLocation
                case .noWeatherDataAvailable:
                    alertType = .noWeatherDataAvailable
                }
                
                // Notify User
                self?.presentAlert(of: alertType)
                
                // Update Child View Controllers
                self?.dayViewController.viewModel = nil
                self?.weekViewController.viewModel = nil
            }
        }
    }
    
    // MARK: -
    
    private func presentAlert(of alertType: AlertType) {
        // Helpers
        let title: String
        let message: String
        
        switch alertType {
        case .notAuthorizedToRequestLocation:
            title = "Unable to Fetch Weather Data for Your Location"
            message = "Rainstorm is not authorized to access your current location. This means it's unable to show you the weather for your current location. You can grant Rainstorm access to your current location in the Settings application."
        case .failedToRequestLocation:
            title = "Unable to Fetch Weather Data for Your Location"
            message = "Rainstorm is not able to fetch your current location due to a technical issue."
        case .noWeatherDataAvailable:
            title = "Unable to Fetch Weather Data"
            message = "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular."
        }
        
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add Cancel Action
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present Alert Controller
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

extension RootViewController: WeekViewControllerDelegate {
    
    func controllerDidRefresh(_ controller: WeekViewController) {
        viewModel.refresh()
    }
    
}
