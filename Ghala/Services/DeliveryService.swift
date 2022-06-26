//
//  DeliveryService.swift
//  Ghala
//
//  Created by mroot on 27/05/2022.
//

import Foundation

struct DeliveryService {
    // MARK: func get Delivery Note by wareHouse
    func getDeliveriesByWH() async throws -> [Delivery] {
        //get url
        guard let url = URL(string: APIConstant.getDeliveryByWareHouse.appending("\(FromUserDefault.warehouseID)")) else {
            throw NetworkError.invalidURL
        }
        //Url Request
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //get Session
        let (data, _) = try await URLSession.shared.data(for: request)
        //decode Delivery Data
        let deliveryDecoded = try JSONDecoder().decode([Delivery].self, from: data)
        //Pass delivery data to Model
        print("Delivery Items: \(deliveryDecoded)")
        return deliveryDecoded
    }
    //MARK: Create Delivery Note
    /*
     func createDeliveryNote(order: OrderElementForDelivery) async throws {
         //get url
         guard let url = URL(string: APIConstant.createDeliveryNote) else {
             throw NetworkError.invalidURL
         }
         //encode data
         let deliveryEncoded = try JSONEncoder().encode(order)
         //url Request
         var request = URLRequest(url: url)
         request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization") //passing jwt token
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.httpMethod = "POST"
         //url Session
         let (data, _) = try await URLSession.shared.upload(for: request, from: deliveryEncoded)
         //get encoded Data
         let decoded = try JSONDecoder().decode(DispachResponse.self, from: data)
         print(decoded)
     }
     */
    
    func createDeliveryNote(delivery: Delivery) async throws {
        //get url
        guard let url = URL(string: APIConstant.createDeliveryNote) else {
            throw NetworkError.invalidURL
        }
        //encode data
        let deliveryEncoded = try JSONEncoder().encode(delivery)
        //url Request
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization") //passing jwt token
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        //url Session
        let (_, response) = try await URLSession.shared.upload(for: request, from: deliveryEncoded)
        //get encoded Data
        print(response)
    }
}
