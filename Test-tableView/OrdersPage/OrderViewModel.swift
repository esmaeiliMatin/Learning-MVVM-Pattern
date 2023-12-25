//
//  OrderViewModel.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-13.
//

import Foundation
import Combine

enum OrderViewModelGeneralViewState {
    case none, loading, didLoad(dataset: [Orders])
}

class OrderViewModel {
    
    // MARK: - Properties
    private let repository: OrderRepository
    public private(set) var dataset: [Orders] = []
    
    public private(set) var observable: CurrentValueSubject<OrderViewModelGeneralViewState, Error> = .init(.none)

    // MARK: - init
    init(repository: OrderRepository) {
        self.repository = repository
        
        fetchData()
    }
    
    func fetchData() {
        
        // Request to server
        // Server responds with a model
        // VM Tells the view that the data is loaded
        // View loads data
        observable.send(.loading)
        
//        POP
        
        repository.fetchData(callback: { [weak self] model in
            guard let weak = self else { return }
            weak.dataset = model.order
            weak.observable.send(.didLoad(dataset: model.order))
        })
    }
}
