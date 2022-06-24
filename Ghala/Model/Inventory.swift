//
//  Inventory.swift
//  Ghala
//
//  Created by mroot on 23/05/2022.
//

import Foundation

class Inventory: Codable, ObservableObject, Identifiable {
    enum CodingKeys: CodingKey {
        case sku
        case name
        case category
        case quantity
        case skuCode
        case ppu //pricePerUnit
        case warehouseId
        case status
    }
    @Published var sku: Int = 0
    @Published var name: String = ""
    @Published var category: String = ""
    @Published var quantity: Int = 0
    @Published var skuCode: String = ""
    @Published var ppu: Int = 0
    @Published var warehouseId: Int = 0
    @Published var status: Status = .outOfStock
    init() {
    }
    //Decode
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sku = try container.decode(Int.self, forKey: .sku)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(String.self, forKey: .category)
        quantity = try container.decode(Int.self, forKey: .quantity)
        skuCode = try container.decode(String.self, forKey: .skuCode)
        ppu = try container.decode(Int.self, forKey: .ppu)
        warehouseId = try container.decode(Int.self, forKey: .warehouseId)
        status = try container.decode(Status.self, forKey: .status)
        
    }
    
    //Encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
    
            try container.encode(name, forKey: .name)
            try container.encode(category, forKey: .category)
            try container.encode(quantity, forKey: .quantity)
            try container.encode(ppu, forKey: .ppu)
            try container.encode(warehouseId, forKey: .warehouseId)
        }
}

enum Status: String, Codable {
    case available = "AVAILABLE"
    case outOfStock = "Out Of Stock"
}


/*
 {
     "sku": 11,
     "name": "1kg Sugar ",
     "category": "Sugar",
     "quantity": 140,
     "ppu": 95,
     "status": "AVAILABLE",
     "skuCode": "GH08OS11",
     "warehouseId": 6,
     "image": null
    },
 */
