//
//  APIConstants.swift
//  Ghala
//
//  Created by mroot on 17/05/2022.
//

import Foundation

enum APIConstant {
    // MARK: USER
    static let checkUserExists = "http://localhost:8080/api/users/exists"
    static let getOTP = "http://localhost:8080/api/otp"
    static let UserLogin = "http://localhost:8080/login"
    static let createUser = "http://localhost:8080/api/users"
    static let getUser = "http://localhost:8080/api/users/get/"
    static let findUserByNumber = "http://localhost:8080/api/users/fetch"
    // MARK: WareHouse
    static let getAllWareHouse = "http://localhost:8080/api/warehouse/all"
    static let registerWareHouse = "http://localhost:8080/api/warehouse"
    // MARK: Inventory
    static let getAllInventory = "http://localhost:8080/api/inventory/all"
    static let addInventory = "http://localhost:8080/api/inventory"
    // MARK: Orders
    static let getOrderById = "http://localhost:8080/api/order/wh/"
    // MARK: Delivery Notes
    static let getDeliveryByWareHouse = "http://localhost:8080/api/deliverynotes/wh/"
    // MARK: STARTS
    static let getStarts = "http://localhost:8080/api/stats/"
}
//enum userWarehouseId {
//    static let wareHouse_Id = Int(UserDefaults.standard.string(forKey: "warehouse_Id")!) //get warehouseId
//}
