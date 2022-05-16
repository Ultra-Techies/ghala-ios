//
//  Service.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import Foundation

@MainActor
class Service: ObservableObject {
    
    @Published var otpCode = OTP()
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case invalidEncoding
        case invalidData
    }
    
    
    //MARK: Check if User Exists
    func checkIfUserExists(user: User) async throws -> check {
        guard let url = URL(string: "http://localhost:8080/api/users/exists") else {
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
            let decoded = try JSONDecoder().decode(check.self, from: data)

        return decoded
    }
    
    
    //MARK: Verify User Password
    func verifyUserLogin(user: User) async throws {
          
          guard let url = URL(string: "http://localhost:8080/login") else {
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
          
          do {
              let (data, _) = try await URLSession.shared.upload(for: request, from: body!)
              let decoded = try JSONDecoder().decode(Token.self, from: data)
              print(decoded.accessToken)
          
          } catch {
              debugPrint(error.localizedDescription)
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
            let decoded = try JSONDecoder().decode(OTP.self, from: data)
            self.otpCode = decoded
            print(decoded.otp)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    //MARK: Create User
    
    func createUser(user: User) async throws {
        
        //print(phone)
        guard let url = URL(string: "http://localhost:8080/api/users") else {
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
