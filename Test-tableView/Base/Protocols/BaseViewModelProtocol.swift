//
//  BaseViewModelProtocol.swift
//  Test-tableView
//
//  Created by Matin on 2024-01-03.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {
    
    associatedtype StateType
    var observable: CurrentValueSubject<StateType, Error> { get }
    
    func fetchData()
}
