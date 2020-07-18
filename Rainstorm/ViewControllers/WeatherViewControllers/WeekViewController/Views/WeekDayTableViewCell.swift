//
//  WeekDayTableViewCell.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/18/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baseTextColor
        label.font = .heavyLarge
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baseTextColor
        label.font = .lightRegular
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
        label.font = .lightSmall
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .lightSmall
        return label
    }()

    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: WeekDayTableViewCell.reuseIdentifier)
        
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Configure Cell
        selectionStyle = .none
        
        addSubview(dayLabel)
        addSubview(dateLabel)
        addSubview(iconImageView)
        addSubview(temperatureLabel)
        addSubview(windSpeedLabel)
        
        dayLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(8)
            make.right.equalTo(iconImageView.snp.left).offset(8)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dayLabel)
            make.right.equalTo(dayLabel)
            make.top.equalTo(dateLabel.snp.bottom)
        }
        
        temperatureLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dateLabel)
            make.bottom.equalToSuperview().inset(8)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.right.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(8)
        }
        
        windSpeedLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.left.equalTo(temperatureLabel.snp.right).offset(-8)
        }
        
    }
    
    // MARK: - Configuration
    
    func configure(with representable: WeekDayRepresentable) {
        dayLabel.text = representable.day
        dateLabel.text = representable.date
        iconImageView.image = representable.image
        windSpeedLabel.text = representable.windSpeed
        temperatureLabel.text = representable.temperature
    }

}

