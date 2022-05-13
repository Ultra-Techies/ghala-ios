//
//  UserViewModel.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    
    //Constant States for the Views
    enum State {
        case notAvailable
        case loading
        case falseN
        case trueN
        //case success(data: Bool)
        case failed(error: Error)
    }
    
    enum ch:Error {
        case failedtoDecode
        case errorFound
    }
    
    @Published var otpCode = OTP()
    
    var state: State = .notAvailable
    
    var userService: Service
    
    init(userService: Service) {
        self.userService = userService
    }
    
    func checkIfUserExists(user: User) async {
        
        self.state = .loading
        
        do {
            let value = try await checkU(user: user)
             print(value)
            if value == false {
                //print("Does not exist")
                self.state = .falseN
            } else {
                //print("Exists")
                self.state = .trueN
            }
            
            
        } catch {
            self.state = .failed(error: error)
        }
    }
    
    func checkU(user: User) async throws -> Bool {
        
        guard let checked = try? await userService.checkIfUserExists(user: user) else {
            throw ch.failedtoDecode
        }
        let checkedNumber = checked.exists
        //print(checkedNumber)
        return checkedNumber
    }
    
    //MARK: -OTP Check
    
    func getOTPCode(user:User) async throws -> String {
        
        guard let otpCode = try? await userService.getOTP1(user: user) else {
            throw ch.failedtoDecode
        }
        self.otpCode.otp = otpCode
        return otpCode

    }
    
    func getCode(user:User) async  throws {
        do {
        let otpCode = try await userService.getOTP3(user: user)
        print(otpCode)
            self.otpCode.otp = otpCode
        //let decodedCode = try JSONDecoder().decode(OTP.self, from: otpCode)
            
            //self.otp.otp = otpCode
            //print("Code is: \(otp.otp)")
          
        }
        catch {
            print(error)
        }
    }
    
    
    func GETOT(user:User) async {
        do {
           let ot =  try await userService.getOTP2(user: user)
            print(ot)
            userService.otpCode.otp = ot.otp
            //self.otp.otp = ot.otp
        } catch {
            print(error)
        }
    }
//    func getOTPCode(user:User) async {
//
//        do {
//            let otpCode = try await userService.getOTP1(user: user)
//            print(otpCode)
//        } catch {
//            print(error)
//        }
//
//    }
    
}


