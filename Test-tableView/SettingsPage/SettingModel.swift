//
//  SettingModel.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-11.
//

import UIKit

enum SettingModelTypeAndValueEnum: Decodable {
    case IconLabelLabelRow(_ value: String), IconLabelSwitchRow(_ value: Bool), IconLabelChevronRow, unknown
}

struct SettingModel: Decodable {
    enum CodingKeys: CodingKey {
        case type, iconName, title, value, switchButton
    }
    
    let typeAndValue: SettingModelTypeAndValueEnum
    let iconName: String
    let title: String
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        iconName = try container.decode(String.self, forKey: .iconName)
        title = try container.decode(String.self, forKey: .title)
        
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "IconLabelLabelRow":
            let value = try container.decode(String.self, forKey: .value)
            self.typeAndValue = .IconLabelLabelRow(value)
        case "IconLabelSwitchRow":
            let value = try container.decode(Bool.self, forKey: .switchButton)
            self.typeAndValue = .IconLabelSwitchRow(value)
        case "IconLabelChevronRow":
            self.typeAndValue = .IconLabelChevronRow
        default:
            self.typeAndValue = .unknown
        }
    }
}
