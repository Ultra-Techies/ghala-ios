//
//  User.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import Foundation

/**
 
     {
         "id": 4,
         "email": "kk@gmail.com",
         "phoneNumber": "+254748849086",
         "assignedWarehouse": null,
         "password": "$2a$10$JBAy9Zaqx9VksDRO51GKkuf1ANj.C8y2EbG.jM1nfhCsfZaFWSfre",
         "role": "ADMIN",
         "firstName": "Joshua",
         "lastName": "Kilz",
         "profilePhoto": null
     }
 
 */


class User: Codable, ObservableObject, Identifiable {
    enum CodingKeys: CodingKey{
            case id
            case phoneNumber
            case email
            case assignedWarehouse
            case firstName
            case lastName
            case password
            case profilePhoto
        }
      
        @Published var id: Int = 0
        @Published var phoneNumber = ""
        @Published var email = ""
        @Published var assignedWarehouse: Int? = 0
        @Published var firstName = ""
        @Published var lastName = ""
        @Published var password = ""
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
            password = try container.decode(String.self, forKey: .password)
            // assignedWarehouse = try container.decode(Int.self, forKey: .assignedWarehouse)
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



//class User: Codable, ObservableObject, Identifiable {
//    enum CodingKeys: CodingKey{
//            case id
//            case phoneNumber
//            case email
//            case assignedWarehouse
//            case firstName
//            case lastName
//            case password
//        }
//
//        @Published var id: Int = 0
//        @Published var phoneNumber = ""
//        @Published var email = ""
//        //@Published var assignedWarehouse: Int = 0
//        @Published var firstName = ""
//        @Published var lastName = ""
//        @Published var password = ""
//
//    init() {
//        }
//
//        required init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            id = try container.decode(Int.self, forKey: .id)
//            phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
//            email = try container.decode(String.self, forKey: .email)
//           // assignedWarehouse = try container.decode(Int.self, forKey: .assignedWarehouse)
//            firstName = try container.decode(String.self, forKey: .firstName)
//            lastName = try container.decode(String.self, forKey: .lastName)
//            //password = try container.decode(String.self, forKey: .password)
//        }
//        func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//            try container.encode(id, forKey: .id)
//            try container.encode(phoneNumber, forKey: .phoneNumber)
//            try container.encode(email, forKey: .email)
//           // try container.encode(assignedWarehouse, forKey: .assignedWarehouse)
//            try container.encode(firstName, forKey: .firstName)
//            try container.encode(lastName, forKey: .lastName)
//            try container.encode(password, forKey: .password)
//        }
//}

// MARK: - User2
class User2: Codable {
    let id: Int
    let email, phoneNumber: String
    let assignedWarehouse: Int
    let role, firstName, lastName: String
    let profilePhoto: JSONNull?

    init(id: Int, email: String, phoneNumber: String, assignedWarehouse: Int, role: String, firstName: String, lastName: String, profilePhoto: JSONNull?) {
        self.id = id
        self.email = email
        self.phoneNumber = phoneNumber
        self.assignedWarehouse = assignedWarehouse
        self.role = role
        self.firstName = firstName
        self.lastName = lastName
        self.profilePhoto = profilePhoto
    }
}

// MARK: USER PIN Response
struct Pin: Codable {
    let verified: Bool
}
// MARK: Create User Response
struct CreateUserResponse: Codable {
    let id: Int
}

class OTP: Codable, ObservableObject, Identifiable {
    enum CodingKeys: CodingKey{
            case otp
        }
    @Published var otp = ""
    init() {
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        otp = try container.decode(String.self, forKey: .otp)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(otp, forKey: .otp)
    }
}
