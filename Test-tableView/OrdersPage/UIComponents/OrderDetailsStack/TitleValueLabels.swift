//
//  TitleValueLabels.swift
//  Test-tableView
//
//  Created by Matin on 2023-11-16.
//

import UIKit

class TitleValueLabels: UIView {
    
    // MARK: - properties
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.textColor = .systemGray
        view.textAlignment = .left
        return view
    }()
    
    lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.textColor = .black
        view.textAlignment = .left
        return view
    }()
    
    // MARK: - init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect = .zero, title: String, value: String? = nil) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 18, left: 0, bottom: 0, right: 0))
        titleLabel.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 0, bottom: 0, right: 0))
        addSubview(valueLabel)
        valueLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 50, left: 0, bottom: 0, right: 0))
        valueLabel.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 0, bottom: 0, right: 0))
        
        configure(staticText: title, dynamicText: value)
    }
    
    func configure(staticText: String, dynamicText: String?) {
        titleLabel.text = staticText
        valueLabel.text = dynamicText
    }
}
