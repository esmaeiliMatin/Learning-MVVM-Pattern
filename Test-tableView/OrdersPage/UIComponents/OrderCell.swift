//
//  OrderCell.swift
//  Test-tableView
//
//  Created by Matin on 2023-11-14.
//

import UIKit

class OrderCell: UITableViewCell {
    
    // MARK: - Properties
    lazy var cellSeparatorView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var statusIconLabel: PurchasesStatusIconLabel = {
        let view = PurchasesStatusIconLabel()
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.textColor = .systemGray
        view.textAlignment = .left
        return view
    }()
    
    private lazy var detailLabel: OrderDetailsLabel = {
        let view = OrderDetailsLabel()
        return view
    }()
    
    private lazy var imageStack: UIStackView = {
        let view = UIStackView()
        view.distribution = .equalSpacing
        view.axis = .horizontal
        return view
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        cellSeparatorView.backgroundColor = #colorLiteral(red: 0.965680182, green: 0.965680182, blue: 0.965680182, alpha: 1)
        contentView.addSubview(cellSeparatorView)
        cellSeparatorView.alignAllEdgesWithSuperview(side: .leadingAndTrailing, .init(top: 0, left: 0, bottom: 0, right: 0))
        cellSeparatorView.alignAllEdgesWithSuperview(side: .bottom, .init(top: 0, left: 0, bottom: 0, right: 0))
        cellSeparatorView.alignAllEdgesWithSuperview(side: .top, .init(top: 320, left: 0, bottom: 0, right: 0))
        
        addSubview(statusIconLabel)
        statusIconLabel.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 22, bottom: 0, right: 0))
        statusIconLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 22, left: 0, bottom: 0, right: 0))
        
        addSubview(dateLabel)
        dateLabel.alignAllEdgesWithSuperview(side: .trailing, .init(top: 0, left: 0, bottom: 0, right: -22))
        dateLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 30, left: 0, bottom: 0, right: 0))
        
        addSubview(detailLabel)
        detailLabel.setSize(height: 80)
        detailLabel.alignAllEdgesWithSuperview(side: .leadingAndTrailing, .init(top: 0, left: 30, bottom: 0, right: -30))
        detailLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 90, left: 0, bottom: 0, right: 0))
        
        addSubview(imageStack)
        imageStack.alignAllEdgesWithSuperview(side: .top, .init(top: 200, left: 0, bottom: 0, right: 0))
        imageStack.alignAllEdgesWithSuperview(side: .leadingAndTrailing, .init(top: 0, left: 22, bottom: 0, right: -22))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - functions
    func configurate(order: Order) {
        
        statusIconLabel.icon.setImage(imageName: String(order.status.resource_icon))
        statusIconLabel.icon.tintColor = UIColor(hex: order.status.color)
        statusIconLabel.label.text = order.status.text
        statusIconLabel.label.textColor = UIColor(hex: order.status.color)
        
        dateLabel.text = CustomDateFormater.formatDate(order.date)
        detailLabel.configure(idValue: order.code, deliveryValue: order.address.name, paymentValue: ("$" + String(order.pay)))
        
        imageStack.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        for i in 0...order.products.count - 1 {
            let image = ProductImageView(imageName: order.products[i].images[0].url, hasCountOfProductLabel: true, count: order.products[i].count)
            imageStack.addArrangedSubview(image)
            
            if i == 3 && order.products.count > 4 {
                image.addOverlay(countOfOtherProducts: order.products.count - 3)
                image.countOfProduct.isHidden = true
                imageStack.addArrangedSubview(image)
                break
            }
        }
    }
}
