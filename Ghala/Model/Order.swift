//
//  Order.swift
//  Ghala
//
//  Created by mroot on 24/05/2022.
//

import Foundation
// MARK: - Order
struct Order: Codable {
    let order: [Order]
}
// MARK: - OrderElement
struct OrderElement: Codable {
    let id: Int
    let createdDate, createdTime, due, deliveryWindow: String
    let customerName, orderCode: String
    let value: Int
    let status: String
    let items: [Item]
    let route: String
    let warehouseID: Int

    enum CodingKeys: String, CodingKey {
        case id, createdDate, createdTime, due, deliveryWindow, customerName, orderCode, value, status, items, route
        case warehouseID = "warehouseId"
    }
}

// MARK: - Item
struct Item: Codable {
    let sku, quantity: Int
    let name: String
    let ppu, totalPrice: Int
}
