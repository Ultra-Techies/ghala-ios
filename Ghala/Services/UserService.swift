//
//  Service.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import Foundation

@MainActor
class UserService: ObservableObject {
    @Published var us = User2(id: 0, email: "", phoneNumber: "", assignedWarehouse: 0, role: "", firstName: "", lastName: "", profilePhoto: nil)
    @Published var user = User()
    
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
    
    // MARK: Verify User Password
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
    func findByPhone(user: User) async throws {
        
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
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST" // Set HTTP Request Body
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
            let decoded = try JSONDecoder().decode(User2.self, from: data)
            //save User Id & WarehouseID to userDefaults
            print("User Warehouse = \(decoded.assignedWarehouse)")
             UserDefaults.standard.set(decoded.assignedWarehouse, forKey: "warehouse_Id")
             UserDefaults.standard.set(decoded.id, forKey: "user_Id")
            self.us = decoded
        } catch {
            print(error)
        }
    }
    
    // MARK: Find by ID
    func getUser() async throws {
        guard let url = URL(string: APIConstant.getUser.appending("\(FromUserDefault.userID)")) else {
            throw NetworkError.invalidURL
        }
        print(url)
        let (data, _) = try await URLSession.shared.data(from: url)
        //decoded JSON
        let decodedUserData = try JSONDecoder().decode(User.self, from: data)
        self.user = decodedUserData
        print("Get User: \(decodedUserData)")
    }
    
    func updateUser(user: User) async throws {
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
        do {
            let (_, response) = try await URLSession.shared.upload(for: request, from: userEncoded)
            print(response)
        } catch {
            debugPrint(error)
        }
    }
    // MARK: Get all users
    func getAllUsers() async throws {
        
        //print(phone)
        guard let url = URL(string: "http://localhost:8080/api/users/all") else {
            throw NetworkError.invalidURL
        }
        
        //let token = UserDefaults.standard.string(forKey: "access_token")
        //print("Token is \(token!)")
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(FromUserDefault.token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET" // Set HTTP Request Body
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode([User].self, from: data)
            print(decoded)
            
        } catch {
            print(error)
        }
    }
}
