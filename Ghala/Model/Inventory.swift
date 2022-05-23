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
