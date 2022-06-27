//
//  User.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import Foundation

class User: Codable, ObservableObject, Identifiable {
    enum CodingKeys: CodingKey{
            case id
            case phoneNumber
            case email
            case assignedWarehouse
            case firstName
            case lastName
            case password
            case role
            case profilePhoto
        }
      
        @Published var id: Int = 0
        @Published var phoneNumber = ""
        @Published var email = ""
        @Published var assignedWarehouse: Int? = 0
        @Published var firstName = ""
        @Published var lastName = ""
        @Published var password = ""
        @Published var role = ""
        @Published var profilePhoto: JSONNull? = nil
        
    init() {
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
        
            id = try container.decode(Int.self, forKey: .id)
            phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
            email = try container.decode(String.self, forKey: .email)
            firstName = try container.decode(String.self, forKey: .firstName)
            lastName = try container.decode(String.self, forKey: .lastName)
            assignedWarehouse = try container.decode(Int?.self, forKey: .assignedWarehouse)
            role = try container.decode(String.self, forKey: .role)
            //password = try container.decode(String.self, forKey: .password)
            //profilePhoto = try container.decode(JSONNull.self, forKey: .profilePhoto)
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(phoneNumber, forKey: .phoneNumber)
            try container.encode(email, forKey: .email)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
            try container.encode(password, forKey: .password)
            //try container.encode(profilePhoto, forKey: .profilePhoto)
            // try container.encode(assignedWarehouse, forKey: .assignedWarehouse)
        }
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    public var hashValue: Int {
        return 0
    }
    public init() {}
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: VERIFY User Response
struct checkPhoneStatus: Codable {
    let exists: Bool
}

// MARK: TOKEN Response
struct Token: Codable {
    let accessToken, refreshToken: String
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

// MARK: OTP
struct OTP: Codable {
    var otp: String
}
