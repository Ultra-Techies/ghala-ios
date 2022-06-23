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
    @Published var toLogin: Bool = false
    @Published var toOTP: Bool = false
    @Published var toPin: Bool = false
    @Published var toContentView: Bool = false
    @Published var toAccountSetUp: Bool = false
    @Published var showToast = false
    
    @Published var user: User = .init()
    //Pin And OTP TextFields
    @Published var pinText: String = ""
    @Published var pinTextFields: [String] = Array(repeating: "", count: 4)
    @Published var otpCode: String = ""

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
    // MARK: OTP
    func getOTP(user: User) async {
        do {
            print("User Number in OTP: \(user.phoneNumber)")
            let otpValue = try await userService.getOTP(user: user)
            print("OTP Value: \(otpValue)")
            otpCode = otpValue.otp
            print("OTP Code is: ")
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Verify OTP
    func verifyOTP(otpValue: String) async {
            isLoading = true
            pinText = pinTextFields.reduce("") { partialResult, value in
                partialResult + value
            }
            if otpValue != pinText {
                let errorMessage = "Invalid OTP"
                handleError(error: errorMessage)
            } else {
                isLoading = false
                toAccountSetUp = true
            }
    }
    // MARK: Create User
    func createUser(user: User) async {
        do {
            isLoading = true
            try await userService.createUser(user: user)
            isLoading = false
            showToast = true
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Find User by PhoneNumber
    func findByPhoneNumber(user: User) async {
        do {
            let userDetails = try await userService.findByPhone(user: user)
            self.user = userDetails
            let userWareHouse = userDetails.assignedWarehouse ?? 0
            print("User WareHouse: \(userWareHouse)")
            if userWareHouse == 0 {
                DispatchQueue.main.async {
                    self.showAlert.toggle()
                }
            }
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Update User
    func updateUser(user: User) async {
        do {
            isLoading = true
            let statusResponse = try await userService.updateUser(user: user)
            print("Status Response \(statusResponse)")
            isLoading = false
            self.showAlert.toggle()
            
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Error
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
}
