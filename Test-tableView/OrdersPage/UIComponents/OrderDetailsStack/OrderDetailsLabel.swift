//
//  OrderDetailsLabel.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-21.
//

import UIKit

class OrderDetailsLabel: UIView {
    
    // MARK: - properties
    private lazy var stack: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .horizontal
        return view
    }()
    
    lazy var orderIdLabels: TitleValueLabels = {
       let label = TitleValueLabels(title: "Order ID")
        return label
    }()
    
    lazy var orderDeliverLabels: TitleValueLabels = {
       let label = TitleValueLabels(title: "Deliver To")
        return label
    }()
    
    lazy var orderPaymentLabels: TitleValueLabels = {
       let label = TitleValueLabels(title: "Total Payment")
        return label
    }()
    
    // MARK: - init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect = .zero, idValue: String? = nil, deliveryValue: String? = nil, paymentValue: String? = nil) {
        super.init(frame: frame)
        
        stack.addArrangedSubview(orderIdLabels)
        stack.addArrangedSubview(orderDeliverLabels)
        stack.addArrangedSubview(orderPaymentLabels)
        
        addSubview(stack)
        stack.alignAllEdgesWithSuperview(side: .allSides, .init(top: 0, left: 0, bottom: 0, right: 0))
        
        configure(idValue: idValue, deliveryValue: deliveryValue, paymentValue: paymentValue)
    }
    
    func configure(idValue: String?, deliveryValue: String?, paymentValue: String?) {
        orderIdLabels.valueLabel.text = idValue
        orderDeliverLabels.valueLabel.text = deliveryValue
        orderPaymentLabels.valueLabel.text = paymentValue
    }
}
