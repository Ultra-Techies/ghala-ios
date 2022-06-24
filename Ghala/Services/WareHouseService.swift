//
//  WareHouseService.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import Foundation

struct WareHouseService {
    
    // MARK: Get All WareHouses
    func getAllWareHouse() async throws -> [WareHouse] {
        //get url
        guard let url = URL(string: APIConstant.getAllWareHouse) else {
            throw NetworkError.invalidURL
        }
        //request URLSession
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization") //set token from UserDefault
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        //decode data
        let decodedData = try JSONDecoder().decode([WareHouse].self, from: data)
        return decodedData
    }
    
    // MARK: Add WareHouse
    func addWareHouse(warehouse: WareHouse) async throws {
        //get url
        guard let url = URL(string: APIConstant.registerWareHouse) else {
            throw NetworkError.invalidURL
        }
        //encodeData
        guard let addWarehouse = try? JSONEncoder().encode(warehouse) else {
            throw NetworkError.failedToEncode
        }
        //get token and URLRequest from url
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        //Upload Encoded Warehouse
        let (_, response) = try await URLSession.shared.upload(for: request, from: addWarehouse)
        print("Warehouse Uploaded response: \(response)")
    }
}
