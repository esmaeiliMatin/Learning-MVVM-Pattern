//
//  SettingsViewModel.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-13.
//

import Foundation
import Combine

enum SettingsViewModelGeneralViewState {
    case none, loading, didLoad(dataset: [SettingModel])
}

class SettingsViewModel: SettingsViewModelProtocol {
    
    // MARK: - Properties
    typealias StateType = SettingsViewModelGeneralViewState
    private let repository: SettingsRepository
    public private(set) var dataset: [SettingModel] = []
    public private(set) var observable: CurrentValueSubject<StateType, Error> = .init(.none)
    
    // MARK: - init
    init(repository: SettingsRepository) {
        self.repository = repository
        fetchData()
    }
    
    func fetchData() {
        observable.send(.loading)
        
        repository.fetchData(callback: { [weak self] model in
            guard let self else { return }
            self.dataset = model.settingRows
            observable.send(.didLoad(dataset: dataset))
        })
    }
}
