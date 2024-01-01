//
//  OrderRepository.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-10.
//

import UIKit
import Dispatch

class OrderRepository: ApplicationRepositoryProtocol {
    
    let resourceName = "OrderUIViewModelData"
    
    func fetchData(callback: @escaping (OrderList) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if let result: OrderList = decodedOrderData(resourceName: resourceName) {
                callback(result)
            } else {
                fatalError("Decoding failed for resource: \(resourceName)")
            }
        }
    }
}
