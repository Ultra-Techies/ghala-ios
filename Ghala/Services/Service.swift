//
//  Service.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import Foundation


class Service: ObservableObject {
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case invalidEncoding
        case invalidData
    }
    
    
    //MARK: Check if User Exists
    func checkIfUserExists(user: User) async throws -> check {
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
        
       // do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
            print(data)
        
            //get the status report from server
                 guard let response = response as? HTTPURLResponse,
                       response.statusCode == 200 else {
                     throw NetworkError.invalidResponse
                 }
            
            //print(response)
            
            let decoded = try JSONDecoder().decode(check.self, from: data)
            //print(decoded.exists)
            
            // let stringValue = String(decoding: usenumber, as: UTF8.self)
//        } catch {
//            print(error.localizedDescription)
//        }
        return decoded
        
    }
    
    //MARK: Verify User
    //TO DO
    
    func verifyUser(user: User) async throws {
        
        guard let url = URL(string: "http://localhost:8080/api/users") else {
            throw NetworkError.invalidURL
        }
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
                throw NetworkError.invalidEncoding
            }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = phoneEncoded // Set HTTP Request Body
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
            print(data)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    //MARK: GET OTP
    func getOTP(user: User) async throws {
        guard let url = URL(string: "http://localhost:8080/api/otp") else {
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
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
            let decoded = try JSONDecoder().decode(check.self, from: data)
            print(decoded)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    //MARK: Create User
    
    func createUser(user: User) async throws {
        
        //print(phone)
        guard let url = URL(string: "http://localhost:8080/api/user") else {
            throw NetworkError.invalidURL
        }
        
        //let number = "+254748849086"
        
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
                throw NetworkError.invalidEncoding
            }
        
       // print(phoneEncoded)
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = phoneEncoded // Set HTTP Request Body
            
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
            print(data)
        
           // let decoded = try JSONDecoder().decode(User.self, from: data)
            //print(decoded.phoneNumber)
        } catch {
            print(error.localizedDescription)
        }
    }
}
