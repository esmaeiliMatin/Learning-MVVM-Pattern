//
//  OrderViewModelProtocol.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-31.
//

import Foundation
import Combine

protocol OrderViewModelProtocol: BaseViewModelProtocol {
    
    var dataset: [Order] { get }
    var filteredDataset: [Order] { get }
    var observable: CurrentValueSubject<OrderViewModelGeneralViewState, Error> { get }
    
    func fetchData()
}
