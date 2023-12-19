//
//  OrderViewModel.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-13.
//

import Foundation

class OrderViewModel {
    
    // MARK: - Properties
    private let repository: OrderRepository
    public private(set) var dataset: [Order] = []

    // MARK: - init
    init(repository: OrderRepository) {
        self.repository = repository
        
        fetchData()
    }
    func fetchData() {
        dataset = repository.fetchData().order
     
    }
}
