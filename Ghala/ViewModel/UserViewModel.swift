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
    
    func checkIfUserExists(user: User) async {
        
        self.state = .loading
        
        do {
            
            let value = try await checkU(user: user)
             print(value)
//
//            self.state = .success(data: value)

            if value == false {
                //print("Does not exist")
                self.state = .falseN
            } else {
                //print("Exists")
                self.state = .trueN
            }
            
           // self.state = .success(data: checked)
            
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
    
}


//func checkUserExist(user: User) async {
//    self.state = .loading
//
//    do {
//
//        //let usenumber = try await userService.checkIfUserExists(user: user)
//       // let stringValue = String(decoding: usenumber, as: UTF8.self)
//        //self.state = .success(data: usenumber)
//
//    }catch {
//        self.state = .failed(error: error)
//        debugPrint(error.localizedDescription)
//    }
//
//}
