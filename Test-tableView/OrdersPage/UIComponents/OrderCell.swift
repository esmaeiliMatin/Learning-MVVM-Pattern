//
//  OrderCell.swift
//  Test-tableView
//
//  Created by Matin on 2023-11-14.
//

import UIKit

class OrderCell: UITableViewCell {
    
    // MARK: - Property
    lazy var view: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.textColor = .systemGray
        view.textAlignment = .left
        return view
    }()
    
    lazy var orderIDLabel: PurchasesInfoLabels = {
        let view = PurchasesInfoLabels(frame: .zero, staticText: "Order ID", dynamicText: "")
        return view
    }()
    
    lazy var deliverToLabel: PurchasesInfoLabels = {
        let view = PurchasesInfoLabels(frame: .zero, staticText: "Deliver To", dynamicText: "")
        return view
    }()
    
    lazy var totalPaymentLabel: PurchasesInfoLabels = {
        let view = PurchasesInfoLabels(frame: .zero, staticText: "Total Payment", dynamicText: "")
        return view
    }()
    
    lazy var statusIcon = PurchasesStatusIcon(frame: .zero)
    
    private lazy var infoStack: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .horizontal
        return view
    }()
    
    private lazy var imageStack: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .horizontal
        return view
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        view.backgroundColor = .white
        contentView.addSubview(view)
        view.alignAllEdgesWithSuperview(side: .allSides, .init(top: 0, left: 0, bottom: -12, right: 0))
        
        view.addSubview(statusLabel)
        statusLabel.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 70, bottom: 0, right: 0))
        statusLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 30, left: 0, bottom: 0, right: 0))
        
        view.addSubview(statusIcon)
        statusIcon.setSize(width: 34, height: 34)
        statusIcon.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 22, bottom: 0, right: 0))
        statusIcon.alignAllEdgesWithSuperview(side: .top, .init(top: 22, left: 0, bottom: 0, right: 0))
        
        view.addSubview(dateLabel)
        dateLabel.alignAllEdgesWithSuperview(side: .trailing, .init(top: 0, left: 0, bottom: 0, right: -24))
        dateLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 30, left: 0, bottom: 0, right: 0))
        
        infoStack.addArrangedSubview(orderIDLabel)
        infoStack.addArrangedSubview(deliverToLabel)
        infoStack.addArrangedSubview(totalPaymentLabel)
        view.addSubview(infoStack)
        infoStack.setSize(height: 80)
        infoStack.alignAllEdgesWithSuperview(side: .leadingAndTrailing, .init(top: 0, left: 30, bottom: 0, right: -30))
        infoStack.alignAllEdgesWithSuperview(side: .top, .init(top: 90, left: 0, bottom: 0, right: 0))
        
        view.addSubview(imageStack)
        imageStack.setSize(width: 382, height: 80)
        imageStack.alignAllEdgesWithSuperview(side: .top, .init(top: 200, left: 0, bottom: 0, right: 0))
        imageStack.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 24, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - functions
    
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    func configurate(order: Order) {
        
        statusLabel.text = order.status.text
        dateLabel.text = formatDate(order.date)
        orderIDLabel.dynamicLabel.text = order.code
        deliverToLabel.dynamicLabel.text = order.address.name
        totalPaymentLabel.dynamicLabel.text = "$" + String(order.pay)
        statusIcon.setImage(imageName: String(order.status.resource_icon))
        
        imageStack.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        for (index, product) in order.products.enumerated() {
            if index == 3 {
                let image = OrderListImage(frame: .zero, imageName: product.images[0].url, count: product.count)
                image.setSize(width: 80, height: 80)
                imageStack.addArrangedSubview(image)
                
                let overlayView = UIView(frame: .zero)
                overlayView.setSize(width: image.preferredSize, height: image.preferredSize)
                overlayView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
                overlayView.layer.cornerRadius = 18
                image.imageView.addSubview(overlayView)
                break
            } else {
                let image = OrderListImage(frame: .zero, imageName: product.images[0].url, count: product.count)
                image.setSize(width: 80, height: 80)
                imageStack.addArrangedSubview(image)
            }
        }
    }
}
