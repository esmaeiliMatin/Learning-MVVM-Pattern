//
//  OrderCell.swift
//  Test-tableView
//
//  Created by Matin on 2023-11-14.
//

import UIKit

class OrderCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var separatorView: UIView = {
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
        view.distribution = .fillEqually
        view.axis = .horizontal
        return view
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        separatorView.backgroundColor = #colorLiteral(red: 0.965680182, green: 0.965680182, blue: 0.965680182, alpha: 1)
        contentView.addSubview(separatorView)
        separatorView.alignAllEdgesWithSuperview(side: .leadingAndTrailing, .init(top: 0, left: 0, bottom: 0, right: 0))
        separatorView.alignAllEdgesWithSuperview(side: .bottom, .init(top: 0, left: 0, bottom: 0, right: 0))
        separatorView.alignAllEdgesWithSuperview(side: .top, .init(top: 320, left: 0, bottom: 0, right: 0))
        
        
        addSubview(statusIconLabel)
        statusIconLabel.alignAllEdgesWithSuperview(side: .leading, .init(top: 0, left: 22, bottom: 0, right: 0))
        statusIconLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 22, left: 0, bottom: 0, right: 0))
        
        addSubview(dateLabel)
        dateLabel.alignAllEdgesWithSuperview(side: .trailing, .init(top: 0, left: 0, bottom: 0, right: -22))
        dateLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 30, left: 0, bottom: 0, right: 0))
        
        addSubview(detailLabel)
        detailLabel.setSize(width: 370, height: 80)
        detailLabel.alignAllEdgesWithSuperview(side: .leadingAndTrailing, .init(top: 0, left: 30, bottom: 0, right: -30))
        detailLabel.alignAllEdgesWithSuperview(side: .top, .init(top: 90, left: 0, bottom: 0, right: 0))
        
        addSubview(imageStack)
        imageStack.setSize(height: 100)
        imageStack.alignAllEdgesWithSuperview(side: .top, .init(top: 190, left: 0, bottom: 0, right: 0))
        imageStack.alignAllEdgesWithSuperview(side: .leadingAndTrailing, .init(top: 0, left: 22, bottom: 0, right: -22))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - functions
    func configurate(order: Orders) {
        
        statusIconLabel.icon.setImage(imageName: String(order.status.resource_icon))
        statusIconLabel.label.text = order.status.text
        
        dateLabel.text = CustomDateFormater.formatDate(order.date)
        detailLabel.configure(idValue: order.code, deliveryValue: order.address.name, paymentValue: ("$" + String(order.pay)))
        
        imageStack.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        for i in 0...order.products.count - 1 {
            
            let image = ProductImageView(frame: .zero, imageName: order.products[i].images[0].url, hasCountOfProductLabel: true, count: order.products[i].count)
            imageStack.addArrangedSubview(image)
            
            if i == 3 && order.products.count > 4 {
                let overlayView = UIView(frame: .zero)
                image.imageView.addSubview(overlayView)
                overlayView.setSize(width: image.preferredSize, height: image.preferredSize)
                overlayView.alignAllEdgesWithSuperview(side: .allSides, .init(top: 0, left: 0, bottom: 0, right: 0))
                overlayView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
                overlayView.layer.cornerRadius = 18
                
                let countOfOtherProducts = UILabel(frame: .zero)
                countOfOtherProducts.setSize(width: image.preferredSize, height: image.preferredSize)
                countOfOtherProducts.textAlignment = .center
                countOfOtherProducts.textColor = .white
                countOfOtherProducts.text = "+" + String(order.products.count - 3)
                
                image.countOfProduct.isHidden = true
                image.imageView.addSubview(countOfOtherProducts)
                imageStack.addArrangedSubview(image)
                break
            }
        }
    }
}
