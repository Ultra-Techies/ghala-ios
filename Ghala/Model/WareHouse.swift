//
//  WareHouse.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import Foundation

class WareHouse: Codable, ObservableObject, Identifiable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case location
    }
    @Published var warehouseID : Int = 0
    @Published var name: String = ""
    @Published var location: String = ""
    
    init() {}
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        warehouseID = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(String.self, forKey: .location)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
    }
}
