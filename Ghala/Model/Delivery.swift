//
//  Delivery.swift
//  Ghala
//
//  Created by mroot on 27/05/2022.
//

import Foundation

// MARK: - Delivery
struct Delivery: Codable {
    let id: Int
    let route: String?
    let orders: [OrderElement] //from Order Model
    let status: DeliveryStatus
    let deliveryWindow: String?
    let warehouseID: Int
    let noteCode, createdTime: String

    enum CodingKeys: String, CodingKey {
        case id
        case route
        case orders
        case status
        case deliveryWindow
        case warehouseID = "warehouseId"
        case noteCode
        case createdTime
    }
}
// MARK: Status
enum DeliveryStatus: String, Codable {
    case completed = "COMPLETED"
    case pending = "PENDING"
}
