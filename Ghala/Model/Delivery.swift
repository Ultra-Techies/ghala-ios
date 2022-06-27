//
//  Delivery.swift
//  Ghala
//
//  Created by mroot on 27/05/2022.
//

import Foundation

class Delivery: Codable, ObservableObject ,Identifiable {
    enum CodingKeys: CodingKey {
        case id
        case orderIds
        case route
        case orders
        case status
        case deliveryWindow
        case warehouseId
        case noteCode
        case createdTime
    }
    
    @Published var id: Int = 0
    @Published var orderIds: [Int] = []
    @Published var route = ""
    @Published var orders: [Order] = .init()
    @Published var status: DeliveryStatus = .pending
    @Published var deliveryWindow = ""
    @Published var warehouseId: Int = 0
    @Published var noteCode = ""
    @Published var createdTime = ""
    
    init() {}
    
    required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        route = try container.decode(String.self, forKey: .route)
        orders = try container.decode([Order].self, forKey: .orders)
        status = try container.decode(DeliveryStatus.self, forKey: .status)
        deliveryWindow = try container.decode(String.self, forKey: .deliveryWindow)
        noteCode = try container.decode(String.self, forKey: .noteCode)
         warehouseId = try container.decode(Int.self, forKey: .warehouseId)
     }
         func encode(to encoder: Encoder) throws {
             
             /*
              {
                  "route":"A1",
                  "orderIds":[3,4],
                  "deliveryWindow":"MORNING",
                  "warehouseId":3
              }
              */
             var container = encoder.container(keyedBy: CodingKeys.self)

             try container.encode(route, forKey: .route)
             try container.encode(orderIds, forKey: .orderIds)
             try container.encode(deliveryWindow, forKey: .deliveryWindow)
             try container.encode(warehouseId, forKey: .warehouseId)
         }
}

enum DeliveryStatus: String, Codable {
    case completed = "COMPLETED"
    case pending = "PENDING"
}

/*
 {
     "id": 45,
     "route": "A1",
     "orders": [],
     "status": "COMPLETED",
     "deliveryWindow": "MORNING",
     "warehouseId": 6,
     "noteCode": "GH37DN45",
     "createdTime": "17:57:22"
 },
 */
