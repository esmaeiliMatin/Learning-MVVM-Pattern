//
//  SettingsViewModelProtocol.swift
//  Test-tableView
//
//  Created by Matin on 2024-01-03.
//

import Foundation
import Combine

protocol SettingsViewModelProtocol: BaseViewModelProtocol {
    
    var dataset: [SettingModel] { get }
    var observable: CurrentValueSubject<SettingsViewModelGeneralViewState, Error> { get }
    
    func fetchData()
}
