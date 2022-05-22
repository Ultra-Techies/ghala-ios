//
//  Service.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import Foundation

@MainActor
class UserService: ObservableObject {
    
    @Published var otpCode = OTP()
    @Published var us = User2(id: 0, email: "", phoneNumber: "", assignedWarehouse: nil, role: "", firstName: "", lastName: "", profilePhoto: nil)
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case invalidEncoding
        case invalidData
    }
    
    //MARK: Check if User Exists
    func checkIfUserExists(user: User) async throws -> check {
        guard let url = URL(string: APIConstant.checkUserExists) else {
            throw NetworkError.invalidURL
        }
        
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
                throw NetworkError.invalidEncoding
            }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = phoneEncoded // Set HTTP Request Body
        
            let (data, response) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
            print(data)
        
            //get the status report from server
                 guard let response = response as? HTTPURLResponse,
                       response.statusCode == 200 else {
                     throw NetworkError.invalidResponse
                 }
            let decoded = try JSONDecoder().decode(check.self, from: data)

        return decoded
    }
    
    //MARK: Verify User Password
    func verifyUserLogin(user: User) async throws -> Int {
          
        guard let url = URL(string: APIConstant.UserLogin) else {
              throw NetworkError.invalidURL
          }

          let number = user.phoneNumber
          let pin = user.password
          
        //Passing x-www-form-urlencoded
          var parameters: [String: String] {
              return [
              "phoneNumber": number,
              "password": pin
            ]
          }
          
          var request = URLRequest(url: url)
          request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
          request.httpMethod = "POST"
          let body = parameters.percentEncoded()
          request.httpBody = body
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: body!)
        
        //Get token
        let decoded = try JSONDecoder().decode(Token.self, from: data)
        //save token
        UserDefaults.standard.set(decoded.accessToken, forKey: "access_token")
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        return response.statusCode
      }
    
    //MARK: GET OTP
    func getOTP(user: User) async throws {
        guard let url = URL(string: APIConstant.getOTP) else {
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
            let decoded = try JSONDecoder().decode(OTP.self, from: data)
            self.otpCode = decoded
            print(decoded.otp)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    //MARK: Create User
    func createUser(user: User) async throws {
        
        guard let url = URL(string: APIConstant.createUser) else {
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
            print(data)
        } catch {
            //print(error.localizedDescription)
            debugPrint(error)
        }
    }
    
    //MARK: FindByNumber
    func findByPhone(user: User) async throws {
        
        guard let url = URL(string: APIConstant.findUserByNumber) else {
            throw NetworkError.invalidURL
        }
        
        guard let phoneEncoded = try? JSONEncoder().encode(user) else {
                print("Failed to encode")
                throw NetworkError.invalidEncoding
            }
        let token = UserDefaults.standard.string(forKey: "access_token")
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST" // Set HTTP Request Body
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: phoneEncoded)
            let decoded = try JSONDecoder().decode(User2.self, from: data)
            self.us = decoded
            print(decoded)
        } catch {
            print(error)
        }
        
    }
    
    //MARK: Find by ID
    func getUser() async throws {
        
        let id = 6
        print(id)
        let idConv = String(describing: id)
        print(idConv)
        guard let url = URL(string: APIConstant.getUser.appending(idConv)) else {
            throw NetworkError.invalidURL
        }
        print(url)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let userData = try JSONDecoder().decode(User2.self, from: data)
            print(userData)
        } catch {
            print(error)
        }
    }
    
    //get all users
    func getAllUsers() async throws {
        
        //print(phone)
        guard let url = URL(string: "http://localhost:8080/api/users/all") else {
            throw NetworkError.invalidURL
        }
        
        let token = UserDefaults.standard.string(forKey: "access_token")
        //print("Token is \(token!)")
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
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
