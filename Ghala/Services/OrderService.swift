//
//  OrderService.swift
//  Ghala
//
//  Created by mroot on 24/05/2022.
//

import Foundation
@MainActor
class OrderService: ObservableObject {
    @Published var orderDTO = [OrderElement]()
    @Published var itemsDTO = [Item]()
    //NetworkAPI Status
    enum NetworkError: Error {
        case invalidURL
        case invalideRESPONSE
        case invalidData
    }
    let token = UserDefaults.standard.string(forKey: "access_token") //get current access token from
    let wareHouse_Id = UserDefaults.standard.string(forKey: "warehouse_Id") //get warehouseId
    // MARK: - GetOrdersByID
    func getOrderById() async throws {
        //get URL
        guard let url = URL(string: APIConstant.getOrderById.appending("\(FromUserDefault.warehouseID)")) else {
            throw NetworkError.invalidURL
        }
        //requestURLSession
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //get Session
        let (data, _) = try await URLSession.shared.data(for: request)
        //decode data
        let decodeOrder = try JSONDecoder().decode([OrderElement].self, from: data)
        self.orderDTO = decodeOrder
    }
    // MARK: - Create A Delivery note
    func createDeliveryNote(order: OrderElementForDelivery) async throws {
        //get url
        guard let url = URL(string: APIConstant.createDeliveryNote) else {
            throw NetworkError.invalidURL
        }
        //encode data
        let deliveryEncoded = try JSONEncoder().encode(order)
        //url Request
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization") //passing jwt token
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        //url Session
        let (data, _) = try await URLSession.shared.upload(for: request, from: deliveryEncoded)
        //get encoded Data
        let decoded = try JSONDecoder().decode(DispachResponse.self, from: data)
        print(decoded)
    }
}
