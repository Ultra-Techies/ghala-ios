//
//  Country.swift
//  Ghala
//
//  Created by mroot on 17/05/2022.
//

import Foundation

// MARK: - CountryCode

struct CountryCode: Codable {
    let countryCode: [CountryData]
}

struct CountryData: Codable {
    let name, flag, code, dialCode: String

    enum CodingKeys: String, CodingKey {
        case name, flag, code
        case dialCode = "dial_code"
    }
}
