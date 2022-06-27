//
//  OrderService.swift
//  Ghala
//
//  Created by mroot on 24/05/2022.
//

import Foundation

struct OrderService {
    // MARK: Get Orders By Warehouse Id
    func getOrderById() async throws -> [Order] {
        //get URL
        guard let url = URL(string: APIConstant.getOrderById.appending("\(FromUserDefault.warehouseID)")) else {
            throw NetworkError.invalidURL
        }
        //requestURLSession
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //get Session
        let (data, _) = try await URLSession.shared.data(for: request)
        //decode data
        let decodeOrder = try JSONDecoder().decode([Order].self, from: data)
        return decodeOrder
    }
}
