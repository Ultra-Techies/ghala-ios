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
        case success(data: Data)
        case failed(error: Error)
    }
    
    var state: State = .notAvailable
    
    var userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func checkUserExist(user: User) async {
        self.state = .loading
        
        do {
            
            let usenumber = try await userService.checkIfUserExists(user: user)
           // let stringValue = String(decoding: usenumber, as: UTF8.self)
            self.state = .success(data: usenumber)
            
        }catch {
            self.state = .failed(error: error)
            debugPrint(error.localizedDescription)
        }
        
    }

}
