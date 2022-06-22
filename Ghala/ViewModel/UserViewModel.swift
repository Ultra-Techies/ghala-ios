//
//  UserViewModel.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var isLoading: Bool = false
    // Navigation
    @Published var toOTP: Bool = false
    @Published var toPin: Bool = false
    @Published var toContentView: Bool = false
    
    @Published var user: User = .init()
    //Pin And OTP TextFields
    @Published var pinText: String = ""
    @Published var pinTextFields: [String] = Array(repeating: "", count: 4)

    
    var userService: UserService
    init(userService: UserService) {
        self.userService = userService
    }
    //MARK: -Check If UserExists
    func checkIfUserExists(phoneNumber: String) async {
        do {
            isLoading = true
            user.phoneNumber = phoneNumber
            let checked = try await userService.checkIfUserExists(user: user)
            print(checked.exists)
            let userStatus = checked.exists
            DispatchQueue.main.async {
                self.isLoading = false
                if userStatus != false {
                    self.toPin = true
                    print("To Pin View")
                } else {
                    self.toOTP = true
                    print("To OTP Screen")
                }
            }
        } catch {
            isLoading = false
            print(error.localizedDescription)
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Verify User Password
    func verifyPassword(user: User) async {
        do {
            isLoading = true
            print("User phoneNumber: \(user.phoneNumber)")
            pinText = pinTextFields.reduce("") { partialResult, value in
                partialResult + value
            }
            print("Pin: \(pinText)")
            user.password = pinText
            let statusCode = try await userService.verifyUserLogin(user: user)
            print(statusCode)
            
            DispatchQueue.main.async { [self] in
                self.isLoading = false
                if statusCode != 200 {
                    let errorInvalidPin = "Wrong Pin!!"
                    handleError(error: errorInvalidPin)
                }
                toContentView = true
            }
        } catch {
            isLoading = false
            handleError(error: error.localizedDescription)
        }
    }
    
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
}
