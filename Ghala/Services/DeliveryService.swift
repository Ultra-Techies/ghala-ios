//
//  DeliveryService.swift
//  Ghala
//
//  Created by mroot on 27/05/2022.
//

import Foundation
@MainActor
class DeliveryService: ObservableObject {
    @Published var deliveryDTO = [Delivery]()
    // MARK: func get Delivery Note by wareHouse
    func getDeliveryByWH() async throws {
        //get url
        guard let url = URL(string: APIConstant.getDeliveryByWareHouse.appending(FromUserDefault.warehouseID!)) else {
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
        self.deliveryDTO = deliveryDecoded
    }
}
