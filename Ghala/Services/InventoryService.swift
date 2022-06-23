//
//  InventoryService.swift
//  Ghala
//
//  Created by mroot on 23/05/2022.
//

import Foundation
@MainActor
class InventoryService: ObservableObject {
    enum NetworkError: Error {
        case invalidURL
        case invalideRESPONSE
        case invalidData
    }
    //let token = UserDefaults.standard.string(forKey: "access_token") //get current access token from user Device
    @Published var inventory = [Inventory]()
    // MARK: GET ALL INVENTORY
    func getAllInventory() async throws {
        guard let url = URL(string: APIConstant.getAllInventory) else {
            throw NetworkError.invalidURL
        }
        //urlRequest
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization") //place access_token to header
        request.httpMethod = "GET"
        do {
            //UrlSession
            let (data, _) = try await URLSession.shared.data(for: request)
            //Get Data
            let decodedInventory = try JSONDecoder().decode([Inventory].self, from: data)
            self.inventory = decodedInventory
            print(decodedInventory)
        } catch {
            print(error)
        }
    }
    // MARK: ADD INVENTORY
    func addInventory(inventory: InventoryEncode) async throws {
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
        do {
        //URLSession upload encoded Inventory
        let (data, _) = try await URLSession.shared.upload(for: request, from: encodedInventory)
        
        //Decode the uploaded data
        let decodedInventory = try JSONDecoder().decode(InventoryResponse.self, from: data)
        print(decodedInventory)
        } catch {
            print(error)
        }
    }
}
