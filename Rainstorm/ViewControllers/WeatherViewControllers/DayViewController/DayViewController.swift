//
//  DayViewController.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/11/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DayViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    // MARK: - Views
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baseTextColor
        label.font = .heavyLarge
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .lightSmall
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .baseTintColor
        return view
    }()
    
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .lightRegular
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .lightRegular
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .lightSmall
        return label
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: - Factory Method
    
    static func create(withViewModel viewModel: DayViewModel) -> DayViewController {
        let vc = DayViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .lightBackgroundColor
        
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
        view.addSubview(iconImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(activityIndicatorView)
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.centerX.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalTo(iconImageView)
        }
        
        windSpeedLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(iconImageView)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        activityIndicatorView.startAnimating()
    }
    
    private func setupViewModel() {
        // Hide Activity Indicator View
        activityIndicatorView.stopAnimating()
        
        // Configure Labels
        dateLabel.text = viewModel?.date
        timeLabel.text = viewModel?.time
        windSpeedLabel.text = viewModel?.windSpeed
        temperatureLabel.text = viewModel?.temperature
        descriptionLabel.text = viewModel?.summary
        
        // Configure Icon Image View
        iconImageView.image = viewModel?.image
    }
    
}
