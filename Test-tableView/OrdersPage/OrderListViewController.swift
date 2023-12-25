//
//  OrderListViewController.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-13.
//

import UIKit
import Dispatch
import Combine

class OrderListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
        
    // MARK: - Properties
    lazy var cancellables: [AnyCancellable] = []
    lazy var cellReuseIdentifier = "CustomCell"
    lazy var heightForRowAt = 330.0
    lazy var vm: OrderViewModel = {
       let repository = OrderRepository()
        let vm = OrderViewModel(repository: repository)
        return vm
    }()
    
    lazy var navigationTitle = "My Order"
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.allowsSelection = false
        return view
    }()
    
    lazy var segmentedView = OrderHeaderView()
    
    // MARK: -  view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(tableView)
        tableView.alignAllEdgesWithSuperview(side: .allSides, .init(top: 136, left: 0, bottom: 0, right: 0))
        
        view.addSubview(segmentedView)
        segmentedView.setSize(height: 40)
        segmentedView.alignAllEdgesWithSuperview(side: .top, .init(top: 96, left: 0, bottom: 0, right: 0))
        
        let view = UIActivityIndicatorView()
        
        vm.observable.receive(on: DispatchQueue.main).sink(receiveCompletion: { completion in
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
            case .didLoad(let dataset):
                debugPrint(dataset)
//                weak self
                self.tableView.reloadData()
            }
        }).store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController {
            tabBarController.title = navigationTitle
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.dataset.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! OrderCell
        
        let order = vm.dataset[indexPath.row]
        cell.configurate(order: order)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
}
