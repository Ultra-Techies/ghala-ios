//
//  StartsService.swift
//  Ghala
//
//  Created by mroot on 29/05/2022.
//

import Foundation
@MainActor
class StartsService: ObservableObject {
    @Published var ordervalue = [OrderValueElement]()
    // MARK: GET Starts by Warehouse ID
    func getStarts() async throws {
        guard let url = URL(string: APIConstant.getStarts.appending(FromUserDefault.warehouseID!)) else {
            throw NetworkError.invalidURL
        }
        //get URL Request
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //URLSESSION
        let (data, _) = try await URLSession.shared.data(for: request)
        //get JSON Data
        let decodedStarts = try JSONDecoder().decode(Starts.self, from: data)
        self.ordervalue = decodedStarts.orderValue
        print(decodedStarts)
    }
}
