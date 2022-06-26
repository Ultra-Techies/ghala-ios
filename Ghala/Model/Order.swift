//
//  Order.swift
//  Ghala
//
//  Created by mroot on 24/05/2022.
//

import Foundation

// MARK: Test For Encoding - Adding Order
class Order: Codable, ObservableObject, Identifiable, Equatable, Hashable {
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

     enum CodingKeys: CodingKey {
         case id
         case createdDate
         case createdTime
         case due
         case deliveryWindow
         case customerName
         case orderCode
         case value
         case status
         case items
         case route
         case warehouseId
         
     }

     @Published var id: Int = 0
     @Published var createdDate = ""
     @Published var createdTime = ""
     @Published var due = ""
     @Published var deliveryWindow = ""
     @Published var customerName = ""
     @Published var orderCode = ""
     @Published var value: Int = 0
     @Published var status: OrderStatus = .pending
     @Published var items: [Item] = .init()
     @Published var route = ""
     @Published var warehouseId: Int = 0

     init() {
     }
     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)

         id = try container.decode(Int.self, forKey: .id)
         createdDate = try container.decode(String.self, forKey: .createdDate)
         createdTime = try container.decode(String.self, forKey: .createdTime)
         due = try container.decode(String.self, forKey: .due)
         deliveryWindow = try container.decode(String.self, forKey: .deliveryWindow)
         customerName = try container.decode(String.self, forKey: .customerName)
         orderCode = try container.decode(String.self, forKey: .orderCode)
         value = try container.decode(Int.self, forKey: .value)
         status = try container.decode(OrderStatus.self, forKey: .status)
         items = try container.decode([Item].self, forKey: .items)
         route = try container.decode(String.self, forKey: .route)
         warehouseId = try container.decode(Int.self, forKey: .warehouseId)
     }
         func encode(to encoder: Encoder) throws {
             var container = encoder.container(keyedBy: CodingKeys.self)

             try container.encode(customerName, forKey: .customerName)
             try container.encode(due, forKey: .due)
             try container.encode(deliveryWindow, forKey: .deliveryWindow)
             try container.encode(items, forKey: .items)
             try container.encode(route, forKey: .route)
             try container.encode(warehouseId, forKey: .warehouseId)
             try container.encode(deliveryWindow, forKey: .deliveryWindow)
         }
 }

// MARK: - Item
struct Item: Codable {
    let sku, quantity: Int
    let name: String
    let ppu, totalPrice: Int
}

enum OrderStatus: String, Codable {
    case submitted = "SUBMITTED"
    case pending = "PENDING"
    case delivered = "DELIVERED"
}
