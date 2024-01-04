//
//  SettingsViewController.swift
//  Test-ScrollView
//
//  Created by Matin on 2023-11-08.
//

import UIKit
import Dispatch
import Combine

class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    private var viewModel: (any SettingsViewModelProtocol)?
    private lazy var cancellables: [AnyCancellable] = []
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var ScrollViewStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    // MARK: - init
    init(viewModel: any SettingsViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.alignAllEdgesWithSuperview(side: .allSides, .init(top: 100, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(ScrollViewStack)
        ScrollViewStack.setSize(width: UIScreen.main.bounds.width)
        ScrollViewStack.alignAllEdgesWithSuperview(side: .allSides, .init(top: 10, left: 0, bottom: 0, right: 0))
        
        viewModel?.observable.receive(on: DispatchQueue.main).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                debugPrint("Observable finisehd!")
            case .failure(let failure):
                debugPrint("Observable finisehd with error: \(failure)")
            }
        }, receiveValue: { [weak self] newValue in
            guard let self else { return }
            switch newValue {
            case .none:
                debugPrint("None! On Subscribe wanna do stuff!")
            case .loading:
                debugPrint("Loading...")
            case .didLoad(_):
                createAndAddEachRow(viewModel: self.viewModel as! SettingsViewModel , stack: ScrollViewStack)
            }
        }).store(in: &cancellables)
        
        lazy var logoutButtonContainer = UIView()
        logoutButtonContainer.setSize(height: 112)
        
        lazy var deleteButton = LogoutButton(title: "Log out", iconName: "door.right.hand.open")
        logoutButtonContainer.addSubview(deleteButton)
        deleteButton.setSize(width: 360, height: 66)
        deleteButton.setCenterAnchorToCenterOfSuperview(axis: .vertical)
        deleteButton.setCenterAnchorToCenterOfSuperview(axis: .horizontal)
        
        self.ScrollViewStack.addArrangedSubview(logoutButtonContainer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController {
            tabBarController.title = "Settings"
        }
    }
    
    func createAndAddEachRow(viewModel: SettingsViewModel, stack: UIStackView) {
        
        viewModel.dataset.forEach { model in
            
            var view: BaseSettingsRow
            
            switch model.typeAndValue {
            case .labelRow(let value):
                view = labelRow(model: model, value: value)
                view.setSize(height: BaseSettingsRow.preferredHeight)
                stack.addArrangedSubview(view)
            case .switchRow(let value):
                view = switchRow(model: model, value: value)
                view.setSize(height: BaseSettingsRow.preferredHeight)
                stack.addArrangedSubview(view)
            case .chevronRow:
                view = chevronRow(model: model)
                view.setSize(height: BaseSettingsRow.preferredHeight)
                stack.addArrangedSubview(view)
            case .unknown:
                view = BaseSettingsRow(model: model)
                view.setSize(height: BaseSettingsRow.preferredHeight)
                stack.addArrangedSubview(view)
            }
        }
    }
}
