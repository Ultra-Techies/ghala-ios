//
//  Service.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import Foundation

struct UserService {
    
    // MARK: Check if User Exists
    func checkIfUserExists(user: User) async throws -> checkPhoneStatus {
        guard let url = URL(string: APIConstant.checkUserExists) else {
            throw NetworkError.invalidURL
        }
        //encode phone number
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
            throw NetworkError.failedToEncode
        }
        //get urlRequest
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = phoneEncoded // Set HTTP Request Body
        let (data, response) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
        //get the status report from server
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        let decoded = try JSONDecoder().decode(checkPhoneStatus.self, from: data)
        return decoded
    }
    // MARK: Check Pin
    func verifyUserLogin(user: User) async throws -> Int {
    //get URL
        guard let url = URL(string: APIConstant.UserLogin) else {
            throw NetworkError.invalidURL
        }
        //get user number + pin from User model and pass to x-www-form-urlencoded Formart
        let number = user.phoneNumber
        let pin = user.password
        //Passing x-www-form-urlencoded
        var parameters: [String: String] {
            return [
              "phoneNumber": number,
              "password": pin
            ]
        }
        //get URL Request
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let body = parameters.percentEncoded()
        request.httpBody = body
        //get URLSession
        let (data, response) = try await URLSession.shared.upload(for: request, from: body!)
        //Get JSON Decoded Data
        let decoded = try JSONDecoder().decode(Token.self, from: data)
        // MARK: SAVE TOKEN
        UserDefaults.standard.set(decoded.accessToken, forKey: "access_token")
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        return response.statusCode
      }
    
    // MARK: GET OTP
    func getOTP(user: User) async throws -> OTP {
        guard let url = URL(string: APIConstant.getOTP) else {
            throw NetworkError.invalidURL
        }
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
            throw NetworkError.failedToEncode
            }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = phoneEncoded // Set HTTP Request Body
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
        let decoded = try JSONDecoder().decode(OTP.self, from: data)
        print(decoded.otp)
        return decoded
    }
    
    // MARK: Create User
    func createUser(user: User) async throws {
        guard let url = URL(string: APIConstant.createUser) else {
            throw NetworkError.invalidURL
        }
        guard let userEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
            throw NetworkError.failedToEncode
            }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = userEncoded // Set HTTP Request Body
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: userEncoded)
            print(data)
        } catch {
            debugPrint(error)
        }
    }
    
    // MARK: FindByNumber
    func findByPhone(user: User) async throws -> User {
        print("From Find Phone")
        guard let url = URL(string: APIConstant.findUserByNumber) else {
            throw NetworkError.invalidURL
        }
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
            throw NetworkError.failedToEncode
            }
        //let token = UserDefaults.standard.string(forKey: "access_token")
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        print("token \(FromUserDefault.token!)")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST" // Set HTTP Request Body
        let (data, _) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
        let decoded = try JSONDecoder().decode(User.self, from: data)
        let wareHouseId = decoded.assignedWarehouse ?? 0
        //save User Id & WarehouseID to userDefaults
        UserDefaults.standard.set(wareHouseId, forKey: "warehouse_Id")
        UserDefaults.standard.set(decoded.id, forKey: "user_Id")
        print("Decoded Data: \(decoded.id)")
        print("User Warehouse: \(wareHouseId)")
        return decoded
    }
    // MARK: Update User
    func updateUser(user: User) async throws -> URLResponse {
        guard let url = URL(string: APIConstant.updateUser) else {
            throw NetworkError.invalidURL
        }
        print("USER DEtails: \(user.id) \(user.lastName)")
    
        guard let userEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
                throw NetworkError.failedToEncode
            }
        print("User Encoded: \(userEncoded)")
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = userEncoded // Set HTTP Request Body
        let (_, response) = try await URLSession.shared.upload(for: request, from: userEncoded)
        print(response)
        return response
    }
}
