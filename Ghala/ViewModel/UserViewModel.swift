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
    
    var state: State = .notAvailable
    
    var userService: Service
    
    init(userService: Service) {
        self.userService = userService
    }
        
        //MARK: -Check If UserExists
    func checkIfUserExists(user: User) async throws -> Bool {
        
        guard let checked = try? await userService.checkIfUserExists(user: user) else {
            throw ch.failedtoDecode
        }
        let checkedNumber = checked.exists
        return checkedNumber
    }
    
    //MARK: Verify user Pin
    func checkPin(user: User) async throws -> Bool {
        guard let pin = try? await userService.verifyUser(user: user) else {
            throw ch.failedtoDecode
        }
        let userPin = pin.verified
        return userPin
    }
}


