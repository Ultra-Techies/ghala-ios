//
//  UserFiles.swift
//  Ghala
//
//  Created by mroot on 27/05/2022.
//

import Foundation

enum FromUserDefault {
    static let token = UserDefaults.standard.string(forKey: "access_token") //get current access token from
    static let warehouseID = UserDefaults.standard.integer(forKey: "warehouse_Id") //get warehouseId
    static let userID = UserDefaults.standard.integer(forKey: "user_Id") //get UserId
    
//    static func exists(key: String) -> Bool {
//        //return UserDefaults.standard.object(forKey: key) != nil
//        return UserDefaults.standard.integer(forKey: "warehouse_Id")
//    }
}
