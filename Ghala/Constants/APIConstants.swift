//
//  APIConstants.swift
//  Ghala
//
//  Created by mroot on 17/05/2022.
//

import Foundation
enum BaseUrl {
    static let baseUrl = "http://localhost:8080/api/"
    static let loginUrl = "http://localhost:8080/"
}

enum APIConstant {
    // MARK: USER
    static let checkUserExists = BaseUrl.baseUrl.appending("users/exists")
    static let getOTP = BaseUrl.baseUrl.appending("otp")
    static let UserLogin = BaseUrl.loginUrl.appending("login")
    static let createUser = BaseUrl.baseUrl.appending("users")
    static let getUser = BaseUrl.baseUrl.appending("users/get/")
    static let findUserByNumber =  BaseUrl.baseUrl.appending("users/fetch")
    static let updateUser = BaseUrl.baseUrl.appending("users")
    // MARK: WareHouse
    static let getAllWareHouse = BaseUrl.baseUrl.appending("warehouse/all")
    static let registerWareHouse = BaseUrl.baseUrl.appending("warehouse")
    // MARK: Inventory
    static let getAllInventory = BaseUrl.baseUrl.appending("inventory/all")
    static let addInventory = BaseUrl.baseUrl.appending("inventory")
    // MARK: Orders
    static let getOrderById = BaseUrl.baseUrl.appending("order/wh/")
    static let createDeliveryNote = BaseUrl.baseUrl.appending("deliverynotes")
    // MARK: Delivery Notes
    static let getDeliveryByWareHouse = BaseUrl.baseUrl.appending("deliverynotes/wh/")
    // MARK: STARTS
    static let getStarts = BaseUrl.baseUrl.appending("stats/")
}
