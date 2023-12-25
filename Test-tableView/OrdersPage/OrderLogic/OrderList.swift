//
//  Order.swift
//  Test-tableView
//
//  Created by Matin on 2023-11-22.
//

import UIKit


struct OrderList: Decodable {
    let order: [Orders]
}

struct Orders: Decodable {
    let id: Int
    let code: String
    let date: String
    let pay: Double
    let status: Status
    let address: Address
    let products: [Product]
}

struct Status: Decodable {
    let text: String
    let color: String
    let resource_image: String
    let resource_icon: String
}

struct Address: Decodable {
    let id: Int
    let name: String
}

struct Product: Decodable {
    let id: Int
    let name: String
    let images: [ProductImage]
    let count: Int
}

struct ProductImage: Decodable {
    let url: String
    let type: String
    let blurhash: String?
}
