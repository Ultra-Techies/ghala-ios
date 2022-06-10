//
//  APIConstants.swift
//  Ghala
//
//  Created by mroot on 17/05/2022.
//

import Foundation
enum BaseUrl {
    static let baseUrl = "http://localhost:8080"
}
enum APIConstant {
    // MARK: USER
    static let checkUserExists = BaseUrl.baseUrl.appending("/api/users/exists")
    static let getOTP = BaseUrl.baseUrl.appending("/api/otp")
    static let UserLogin = BaseUrl.baseUrl.appending("/login")
    static let createUser = BaseUrl.baseUrl.appending("/api/users")
    static let getUser = BaseUrl.baseUrl.appending("/api/users/get/")
    static let findUserByNumber =  BaseUrl.baseUrl.appending("/api/users/fetch")
    // MARK: WareHouse
    static let getAllWareHouse = BaseUrl.baseUrl.appending("/api/warehouse/all")
    static let registerWareHouse = BaseUrl.baseUrl.appending("/api/warehouse")
    // MARK: Inventory
    static let getAllInventory = BaseUrl.baseUrl.appending("/api/inventory/all")
    static let addInventory = BaseUrl.baseUrl.appending("/api/inventory")
    // MARK: Orders
    static let getOrderById = BaseUrl.baseUrl.appending("/api/order/wh/")
    // MARK: Delivery Notes
    static let getDeliveryByWareHouse = BaseUrl.baseUrl.appending("/api/deliverynotes/wh/")
    // MARK: STARTS
    static let getStarts = BaseUrl.baseUrl.appending("/api/stats/")
}
//enum userWarehouseId {
//    static let wareHouse_Id = Int(UserDefaults.standard.string(forKey: "warehouse_Id")!) //get warehouseId
//}
