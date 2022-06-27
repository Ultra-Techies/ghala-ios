//
//  InventoryService.swift
//  Ghala
//
//  Created by mroot on 23/05/2022.
//

import Foundation

struct InventoryService {
    
    // MARK: GET ALL INVENTORY
    func getAllInventory() async throws -> [Inventory] {
        guard let url = URL(string: APIConstant.getAllInventory) else {
            throw NetworkError.invalidURL
        }
        //urlRequest
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization") //place access_token to header
        request.httpMethod = "GET"
        //UrlSession
        let (data, _) = try await URLSession.shared.data(for: request)
        //Get Data
        let decodedInventory = try JSONDecoder().decode([Inventory].self, from: data)
        print(decodedInventory)
        return decodedInventory
    }
    // MARK: ADD INVENTORY
    func addInventory(inventory: Inventory) async throws {
        //get Url
        guard let url = URL(string: APIConstant.addInventory) else {
            throw NetworkError.invalidURL
        }
        //encode inventory from Add Inventory
        let encodedInventory = try JSONEncoder().encode(inventory)
        //get Request and set headers
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
  
        //URLSession upload encoded Inventory
        let (_, response) = try await URLSession.shared.upload(for: request, from: encodedInventory)
        print(response)
    }
}
