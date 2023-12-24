//
//  SettingsViewController.swift
//  Test-ScrollView
//
//  Created by Matin on 2023-11-08.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    // MARK: - prareties
    private lazy var viewModel: SettingsViewModel = {
        let repository = SettingsRepository()
        let viewModel = SettingsViewModel(repository: repository)
        return viewModel
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    // MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.alignAllEdgesWithSuperview(side: .allSides, .init(top: 100, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(stack)
        stack.setSize(width: 430)
        stack.alignAllEdgesWithSuperview(side: .allSides, .init(top: 10, left: 0, bottom: 0, right: 0))
        
        viewModel.dataset.forEach { model in
            
            let view: BaseSettingsRow
            
            switch model.typeAndValue {
            case .labelRow(let value):
                view = labelRow(model: model, value: value)
            case .switchRow(let value):
                view = switchRow(model: model, value: value)
            case .chevronRow:
                view = chevronRow(model: model)
            case .unknown:
                view = BaseSettingsRow(model: model)
            }
            
            stack.addArrangedSubview(view)
            view.setSize(height: BaseSettingsRow.preferredHeight)
        }
        
        lazy var logoutButtonContainer = UIView()
        logoutButtonContainer.setSize(height: 112)
        
        lazy var deleteButton = LogoutButton(title: "Log out", iconName: "door.right.hand.open")
        logoutButtonContainer.addSubview(deleteButton)
        deleteButton.setSize(width: 360, height: 66)
        deleteButton.setCenterAnchorToCenterOfSuperview(axis: .vertical)
        deleteButton.setCenterAnchorToCenterOfSuperview(axis: .horizontal)
        
        stack.addArrangedSubview(logoutButtonContainer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController {
            tabBarController.title = "Settings"
        }
    }
}
