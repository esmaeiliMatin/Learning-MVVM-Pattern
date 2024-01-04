//
//  SettingModel.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-11.
//

import UIKit

enum SettingModelTypeAndValueEnum: Decodable {
    case labelRow(_ value: String), switchRow(_ value: Bool), chevronRow, unknown
}

struct SettingModels: Decodable {
    let settingRows: [SettingModel]
}

struct SettingModel: Decodable {
    
    enum CodingKeys: CodingKey {
        case type, iconName, title, value, switchButton
    }
    
    // MARK: - properties
    let typeAndValue: SettingModelTypeAndValueEnum
    let iconName: String
    let title: String
    
    // MARK: - init
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        iconName = try container.decode(String.self, forKey: .iconName)
        title = try container.decode(String.self, forKey: .title)
        
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "IconLabelLabelRow":
            let value = try container.decode(String.self, forKey: .value)
            self.typeAndValue = .labelRow(value)
        case "IconLabelSwitchRow":
            let value = try container.decode(Bool.self, forKey: .switchButton)
            self.typeAndValue = .switchRow(value)
        case "IconLabelChevronRow":
            self.typeAndValue = .chevronRow
        default:
            self.typeAndValue = .unknown
        }
    }
}
