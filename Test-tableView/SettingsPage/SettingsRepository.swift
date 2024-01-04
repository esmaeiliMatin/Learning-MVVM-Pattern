//
//  SettingsRepository.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-11.
//

import UIKit
import Dispatch

class SettingsRepository: ApplicationRepositoryProtocol {
    
    let resourceName = "SettingsUIViewModelData"
    
    func fetchData(callback: @escaping ((SettingModels) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if let result: SettingModels = decodedData(resourceName: resourceName) {
                callback(result)
            } else {
                fatalError("Decoding failed for resource: \(resourceName)")
            }
        }
    }
}
