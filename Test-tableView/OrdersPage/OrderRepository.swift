//
//  OrderRepository.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-10.
//

import UIKit

class OrderRepository: ApplicationRepositoryProtocol {
    
    let resourceName = "OrderUIViewModelData"
    
    func fetchData() -> OrderList {
        decodedDataObject(resourceName: resourceName)!
    }
}
