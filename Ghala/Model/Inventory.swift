//
//  Inventory.swift
//  Ghala
//
//  Created by mroot on 23/05/2022.
//

import Foundation

struct Inventory: Codable {
    let sku: Int
    let name: String
    let category: String
    let quantity: Int
    let ppu: Int //pricePerUnit
    let status: Status //make bool
    let skuCode: String
    let warehouseId: Int
}
//status enum
enum Status: String, Codable {
    case available = "AVAILABLE"
    case outOfStock = "Out Of Stock"
}

//EncodeInventory
class InventoryEncode: Codable, ObservableObject, Identifiable {
    enum CodingKeys: CodingKey {
        case sku
        case name
        case category
        case quantity
        case skuCode
        case ppu //pricePerUnit
        case warehouseId
    }
    @Published var sku: Int = 0
    @Published var name: String = ""
    @Published var category: String = ""
    @Published var quantity: Int = 0
    @Published var skuCode: String = ""
    @Published var ppu: Int = 0
    @Published var warehouseId: Int = 0
    
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
        
    }
    
    //Encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
    
            try container.encode(sku, forKey: .sku)
            try container.encode(name, forKey: .name)
            try container.encode(category, forKey: .category)
            try container.encode(quantity, forKey: .quantity)
            try container.encode(skuCode, forKey: .skuCode)
            try container.encode(ppu, forKey: .ppu)
            try container.encode(warehouseId, forKey: .warehouseId)
        }
}
//responce
struct inventoryResponse: Codable {
    let sku: Int
}
