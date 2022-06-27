//
//  Starts.swift
//  Ghala
//
//  Created by mroot on 29/05/2022.
//

import Foundation

struct Starts: Codable {
    let inventoryValue: Int
    let orderValue: [OrderValue]
}
struct OrderValue: Codable, Hashable {
    var sum: Int
    var month: Double
    var year: Double
    var monthName: String
    var yearName: String
}
/*
 {
     "inventoryValue": 112250,
     "orderValue": [
         {
             "sum": 129250,
             "month": 5.0,
             "year": 2022.0,
             "monthName": "MAY",
             "yearName": "2022"
         }
     ]
 }
 */
