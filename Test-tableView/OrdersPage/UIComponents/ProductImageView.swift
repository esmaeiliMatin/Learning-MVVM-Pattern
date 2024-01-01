//
//  OrderListImageView.swift
//  Test-tableView
//
//  Created by Matin on 2023-11-20.
//

import UIKit

class ProductImageView: UIView {
    
    // MARK: - properties
    lazy var preferredSize = 80.0
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        view.setSize(width: preferredSize, height: preferredSize)
        return view
    }()
    
    lazy var countOfProduct: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        view.textColor = #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 0.5
        view.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        view.layer.masksToBounds = true
        view.textAlignment = .center
        view.setSize(width: 20, height: 20)
        return view
    }()
    
    // MARK: - init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect = .zero, imageName: String, hasCountOfProductLabel: Bool, count: Int) {
        super.init(frame: frame)
        
        setSize(width: preferredSize, height: preferredSize)
        backgroundColor = .clear
        
        imageView.image = UIImage(named: imageName)
        addSubview(imageView)
        imageView.setCenterAnchorToCenterOfSuperview(axis: .horizontal)
        imageView.setCenterAnchorToCenterOfSuperview(axis: .vertical)
        
        if hasCountOfProductLabel == true {
            countOfProduct.text = "X" + String(count)
            addSubview(countOfProduct)
            countOfProduct.setCenterAnchorToCenterOfSuperview(axis: .horizontal)
            countOfProduct.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    func addOverlay(countOfOtherProducts: Int? = nil) {
        let overlayView = UIView(frame: .zero)
        imageView.addSubview(overlayView)
        overlayView.alignAllEdgesWithSuperview(side: .allSides, .init(top: 0, left: 0, bottom: 0, right: 0))
        overlayView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        overlayView.layer.cornerRadius = 18
        
        if let number = countOfOtherProducts {
            let countOfOtherProductsLabel = UILabel(frame: .zero)
            imageView.addSubview(countOfOtherProductsLabel)
            countOfOtherProductsLabel.alignAllEdgesWithSuperview(side: .allSides, .init(top: 0, left: 0, bottom: 0, right: 0))
            countOfOtherProductsLabel.textAlignment = .center
            countOfOtherProductsLabel.textColor = .white
            countOfOtherProductsLabel.text = "+" + String(number)
        }
    }
}
