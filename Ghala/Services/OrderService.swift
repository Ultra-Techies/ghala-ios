//
//  OrderService.swift
//  Ghala
//
//  Created by mroot on 24/05/2022.
//

import Foundation
@MainActor
class OrderService: ObservableObject {
    @Published var orderDTO = [Order]()
    //NetworkAPI Status
    enum NetworkError: Error {
        case invalidURL
        case invalideRESPONSE
        case invalidData
    }
    let token = UserDefaults.standard.string(forKey: "access_token") //get current access token from
    let wareHouse_Id = UserDefaults.standard.string(forKey: "warehouse_Id") //get warehouseId
    //getOrdersByID
    func getOrderById() async throws {
        //get URL
        guard let url = URL(string: APIConstant.getOrderById.appending(wareHouse_Id!)) else {
            throw NetworkError.invalidURL
        }
        //requestURLSession
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //get Session
        let (data,_) = try await URLSession.shared.data(for: request)
        //decode data
        let decodeOrder = try JSONDecoder().decode([Order].self, from: data)
        print(decodeOrder)
        self.orderDTO = decodeOrder
    }
}
