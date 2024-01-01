//
//  OrderHeaderView.swift
//  Test-tableView
//
//  Created by Matin on 2023-11-19.
//

import UIKit

enum SegmentedState: Int {
    case All = 0
    case OnProcess = 1
    case Previous = 2
}

protocol segmentedChangeValueProtocol {
    func segmentedTapped()
}

class segmentedWithIndicator: UIView {
    
    // MARK: - properties
    var delegate: segmentedChangeValueProtocol?
    lazy var segmentedItems = ["All", "On Process", "Previous"]
    lazy var segmentedControl = UISegmentedControl(items: segmentedItems)
    lazy var preferredSegmentedHeight = 40.0
    lazy var indicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 149/255, green: 193/255, blue: 31/255, alpha: 1)
        return view
    }()
    
    // MARK: - init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .clear
        segmentedControl.tintColor = .black
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(named: "segmentedBackground"), for: .normal, barMetrics: .default)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        addSubview(segmentedControl)
        segmentedControl.setSize(width:  UIScreen.main.bounds.width, height: preferredSegmentedHeight)
        segmentedControl.alignAllEdgesWithSuperview(side: .allSides, .init(top: 0, left: 0, bottom: 0, right: 0))
        
        segmentedControl.addSubview(indicator)
    }
    
    convenience init(frame: CGRect = .zero, delegate: segmentedChangeValueProtocol) {
        self.init(frame: frame)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateIndicatorPosition()
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("All")
            delegate?.segmentedTapped()
        case 1:
            print("On Process")
            delegate?.segmentedTapped()
        case 2:
            print("Previous")
            delegate?.segmentedTapped()
        default:
            break
        }
    }
    
    func updateIndicatorPosition() {
        let segmentWidth = CGFloat(143)
        let indicatorX = CGFloat(segmentedControl.selectedSegmentIndex) * segmentWidth
        let indicatorY = (40.0) - 3
        
        UIView.animate(withDuration: (indicator.frame.maxY == 0) ? 0.0 : 0.3) {
            self.indicator.frame = CGRect(x: indicatorX, y: indicatorY, width: segmentWidth, height: 3)
        }
    }
}
