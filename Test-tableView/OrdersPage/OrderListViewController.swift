//
//  OrderListViewController.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-13.
//

import UIKit
import Dispatch
import Combine

class OrderListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, segmentedChangeValueProtocol {
    
    // MARK: - Properties
    lazy var cancellables: [AnyCancellable] = []
    lazy var navigationTitle = "My Order"
    lazy var cellReuseIdentifier = "CustomCell"
    lazy var preferHeightForRowAt = 330.0
    lazy var segmentedView = segmentedWithIndicator()
    lazy var viewModel: OrderViewModel = {
        let repository = OrderRepository()
        let vm = OrderViewModel(repository: repository)
        return vm
    }()
    lazy var tableView: UITableView = {
        let tabel = UITableView()
        tabel.backgroundColor = .white
        tabel.separatorStyle = .none
        tabel.allowsSelection = false
        return tabel
    }()
    
    private lazy var loadingTabelView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .medium
        view.color = .gray
        return view
    }()
    
    // MARK: - view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController {
            tabBarController.title = navigationTitle
        }
    }
    
    // MARK: -  view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(tableView)
        tableView.alignAllEdgesWithSuperview(side: .allSides, .init(top: 136, left: 0, bottom: 0, right: 0))
        
        tableView.addSubview(loadingTabelView)
        loadingTabelView.setCenterAnchorToCenterOfSuperview(axis: .horizontal)
        loadingTabelView.setCenterAnchorToCenterOfSuperview(axis: .vertical)
        
        view.addSubview(segmentedView)
        segmentedView.setSize(height: 40)
        segmentedView.alignAllEdgesWithSuperview(side: .top, .init(top: 96, left: 0, bottom: 0, right: 0))
        segmentedView.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 0, bottom: 0, right: 0))
        
        viewModel.observable.receive(on: DispatchQueue.main).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                debugPrint("Observable finisehd!")
            case .failure(let failure):
                debugPrint("Observable finisehd with error: \(failure)")
            }
        }, receiveValue: { newValue in
            switch newValue {
            case .none:
                debugPrint("None! On Subscribe wanna do stuff!")
            case .loading:
                debugPrint("Loading...")
                self.loadingTabelView.startAnimating()
            case .didLoad(_):
                // weak self
                self.loadingTabelView.stopAnimating()
                self.segmentedTapped()
            }
        }).store(in: &cancellables)
    }
    
    func segmentedTapped() {
        viewModel.filterOrders(by: segmentedView.segmentedControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredDataset.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! OrderCell
        
        let order = viewModel.filteredDataset[indexPath.row]
        cell.configurate(order: order)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return preferHeightForRowAt
    }
}
