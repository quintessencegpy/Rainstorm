//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by Pengyu Gou on 7/11/20.
//  Copyright © 2020 Cyberhex. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate: class {
    func controllerDidRefresh(_ controller: WeekViewController)
}

final class WeekViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: WeekViewControllerDelegate?
    
    // MARK: -
    
    var viewModel: WeekViewModel? {
        didSet {
            setupViewModel()
        }
    }

    // MARK: -
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = 44.0
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        
        // Set Refresh Control
        tableView.refreshControl = refreshControl
        
        return tableView
    }()

    // MARK: -
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        return view
    }()

    // MARK: -
    
    private lazy var refreshControl: UIRefreshControl = {
        // Initialize Refresh Control
        let refreshControl = UIRefreshControl()
        
        // Configure Refresh Control
        refreshControl.tintColor = .baseTintColor
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        return refreshControl
    }()

    // MARK: - Factory Method
    
    static func create(withViewModel viewModel: WeekViewModel) -> WeekViewController {
        let vc = WeekViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        // Configure View
        view.backgroundColor = .white
        
        activityIndicatorView.startAnimating()
        
        tableView.register(WeekDayTableViewCell.self, forCellReuseIdentifier: WeekDayTableViewCell.reuseIdentifier)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Actions
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        // Notify Delegate
        delegate?.controllerDidRefresh(self)
    }
    
    // MARK: - Helper Methods
    
    private func setupViewModel() {
        // Hide Activity Indicator View
        activityIndicatorView.stopAnimating()
        
        // Hide Refresh Control
        refreshControl.endRefreshing()

        // Update Table View
        tableView.reloadData()
        tableView.isHidden = false
    }
    
}

extension WeekViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekDayTableViewCell.reuseIdentifier, for: indexPath) as? WeekDayTableViewCell else {
            fatalError("Unable to Dequeue Week Day Table View Cell")
        }
        
        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        // Configure Cell
        cell.configure(with: viewModel.viewModel(for: indexPath.row))
        
        return cell
    }

}
