//
//  Starts.swift
//  Ghala
//
//  Created by mroot on 29/05/2022.
//

import Foundation

struct Starts: Codable {
    let iventoryValue: Int
    let orderValue: [OrderValueElement]
}
struct OrderValueElement: Codable {
    let sum: Int
    let month: Double
    let year: Double
    let monthName: String
    let yearName: String
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
