//
//  WareHouseService.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import Foundation

@MainActor
class WareHouseService: ObservableObject {
    
    @Published var warehouse = [WarehouseElement1]()
    
    let token = UserDefaults.standard.string(forKey: "access_token")
    
    enum NetworkError: Error {
        case invalidURL, failedEncode ,InvalideResponse, InvalideData
    }
    
    
    func getAllWareHouse() async throws {

        //get url
        guard let url = URL(string: APIConstant.getAllWareHouse) else {
            throw NetworkError.invalidURL
        }

        //request URLSession
        var request = URLRequest(url: url)
        request.setValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization") //set token from UserDefault
        request.httpMethod = "GET"

        do {

            let (data, _) = try await URLSession.shared.data(for: request)

            let decodedData = try JSONDecoder().decode([WarehouseElement1].self, from: data)
            print(decodedData)
            self.warehouse = decodedData
        }
    }
    
    func registerWareHouse(warehouse: WareHouse) async throws {
        
        //get url
        guard let url = URL(string: APIConstant.registerWareHouse) else {
            throw NetworkError.invalidURL
        }
        
        //encodeData
        
        guard let addWarehouse = try? JSONEncoder().encode(warehouse) else {
            throw NetworkError.failedEncode
        }
        
        
        //get token and URLRequest from url
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        //Upload Encoded Warehouse
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: addWarehouse)
        
        //get Json Response from data
        
        let dataDecoded = try JSONDecoder().decode(createResponse.self, from: data)
        print(dataDecoded)
    }
}
