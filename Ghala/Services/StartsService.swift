//
//  StartsService.swift
//  Ghala
//
//  Created by mroot on 29/05/2022.
//

import Foundation

struct StartsService {
    func getStarts() async throws -> Starts {
        guard let url = URL(string: APIConstant.getStarts.appending("\(FromUserDefault.warehouseID)")) else {
            throw NetworkError.invalidURL
        }
        //get URL Request
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //URLSESSION
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedStarts = try JSONDecoder().decode(Starts.self, from: data)
        return decodedStarts
    }
}
