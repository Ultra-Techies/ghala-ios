//
//  UserService.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import Foundation


struct UserService {
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponce
        case invalidEncoding
        case invalidData
    }
    
    func checkIfUserExists(user: User) async throws -> Data {
        
        //check Network
        
        //print(phone)
        guard let url = URL(string: "http://localhost:8080/api/users") else {
            throw NetworkError.invalidURL
        }
        
        //let number = "+254748849086"
        
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
                throw NetworkError.invalidEncoding
            }
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = phoneEncoded // Set HTTP Request Body
            

            let (data, _) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
            print(data)
        
        return data
    }
    
    func check(user: User) async throws -> URLResponse {
        
        guard let url = URL(string: "http://localhost:8080/api/users") else {
            throw NetworkError.invalidURL
        }
        
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
                throw NetworkError.invalidEncoding
            }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = phoneEncoded // Set HTTP Request Body
        
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
        
        
        //check the if the response is valid
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw NetworkError.invalidResponce
            }
        
        return response
        
    }
}
