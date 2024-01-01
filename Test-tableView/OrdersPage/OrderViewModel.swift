//
//  OrderViewModel.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-13.
//

import Foundation
import Combine

enum OrderViewModelGeneralViewState {
    case none, loading, didLoad(dataset: [Order])
}

class OrderViewModel: OrderViewModelProtocol {
    
    // MARK: - Properties
    private let repository: OrderRepository
    public private(set) var dataset: [Order] = []
    public private(set) var filteredDataset: [Order] = []
    public private(set) var observable: CurrentValueSubject<OrderViewModelGeneralViewState, Error> = .init(.none)
    
    // MARK: - init
    init(repository: OrderRepository) {
        self.repository = repository
        fetchData()
    }
    
    func fetchData() {
        observable.send(.loading)
        
        repository.fetchData(callback: { [weak self] model in
            guard let self else { return }
            self.dataset = model.order
            self.observable.send(.didLoad(dataset: model.order))
        })
    }
    
    func filterOrders(by segmentedIndex: Int) {
        switch segmentedIndex {
        case 0:
            filteredDataset = dataset
            break
        case 1:
            filteredDataset = dataset.filter { order in
                return order.status.text == "On Process"
            }
            break
        case 2:
            filteredDataset = dataset.filter { order in
                return order.status.text == "Finished"
            }
            break
        default:
            debugPrint("Segmented item out of range")
        }
    }
}
