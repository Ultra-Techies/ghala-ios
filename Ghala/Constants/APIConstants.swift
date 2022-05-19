//
//  APIConstants.swift
//  Ghala
//
//  Created by mroot on 17/05/2022.
//

import Foundation

enum APIConstant {
    static let checkUserExists = "http://localhost:8080/api/users/exists"
    static let getOTP = "http://localhost:8080/api/otp"
    static let UserLogin = "http://localhost:8080/login"
    static let createUser = "http://localhost:8080/api/users"
    static let getUser = "http://localhost:8080/api/users/get/"
    static let findUserByNumber = "http://localhost:8080/api/users/fetch"
}
