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
struct OrderElement: Codable, Equatable {
    static func == (lhs: OrderElement, rhs: OrderElement) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let createdDate, createdTime, due, deliveryWindow: String
    let customerName, orderCode: String
    let value: Int
    let status: OrderStatus
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
// MARK: Status
enum OrderStatus: String, Codable {
    case submitted = "SUBMITTED"
    case pending = "PENDING"
    case delivered = "DELIVERED"
}

struct DispachResponse: Codable {
    let id: Int
}
//Mark: Order struct for Create delivery
class OrderElementForDelivery: Codable, ObservableObject, Identifiable {
    enum CodingKeys: CodingKey {
        case orderIds
        case route
        case warehouseId
        case deliveryWindow
    }
    @Published var orderIds: [Int] = [0]
    @Published var route = "route1" //MARK: TO-DO fetch from view
    @Published var warehouseId: Int = userWarehouseId.wareHouse_Id!
    @Published var deliveryWindow = "MORNING" //MARK: TO-DO fetch from view
    init() {
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        orderIds = try container.decode([Int].self, forKey: .orderIds)
        route = try container.decode(String.self, forKey: .route)
        warehouseId = try container.decode(Int.self, forKey: .warehouseId)
        deliveryWindow = try container.decode(String.self, forKey: .deliveryWindow)

    }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(orderIds, forKey: .orderIds)
            try container.encode(route, forKey: .route)
            try container.encode(warehouseId, forKey: .warehouseId)
            try container.encode(deliveryWindow, forKey: .deliveryWindow)
        }
}
