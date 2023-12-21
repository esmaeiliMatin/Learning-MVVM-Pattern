//
//  PurchasesStatusIconLabel.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-21.
//

import UIKit

class PurchasesStatusIconLabel: UIView {
    
    // MARK: - properties
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var icon = PurchasesStatusIcon()
    
    let preferredSize = 34.0
    
    // MARK: - init
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setSize(width: 140, height: 50)
        
        addSubview(icon)
        icon.setSize(width: preferredSize, height: preferredSize)
        icon.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 0, bottom: 0, right: 0))
        icon.setCenterAnchorToCenterOfSuperview(axis: .vertical)
        
        addSubview(label)
        label.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 42, bottom: 0, right: 0))
        label.setCenterAnchorToCenterOfSuperview(axis: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
