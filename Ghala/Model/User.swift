//
//  User.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import Foundation

class User: Codable, ObservableObject, Identifiable {
    
    enum CodingKeys: CodingKey{
            case phoneNumber, email, assignedWarehouse, firstName, lastName, password
            
        }
      
        @Published var phoneNumber = ""
        @Published var email = ""
        //@Published var assignedWarehouse: Int = 0
        @Published var firstName = ""
        @Published var lastName = ""
        @Published var password = ""
        
        init() {
            
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
        
            phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
            email = try container.decode(String.self, forKey: .email)
           // assignedWarehouse = try container.decode(Int.self, forKey: .assignedWarehouse)
            firstName = try container.decode(String.self, forKey: .firstName)
            lastName = try container.decode(String.self, forKey: .lastName)
            password = try container.decode(String.self, forKey: .password)
          
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(phoneNumber, forKey: .phoneNumber)
            try container.encode(email, forKey: .email)
           // try container.encode(assignedWarehouse, forKey: .assignedWarehouse)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
            try container.encode(password, forKey: .password)
        }

    
}

struct check: Codable {
    let exists: Bool
   
   // let otp: String
}

struct Pin: Codable {
    let verified: Bool
}


struct Token: Codable {
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}


class OTP: Codable, ObservableObject, Identifiable {
   // var otp: String
    
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


/**
 {
     "email":"idhfggfttgre@com",
     "phoneNumber":"0756549580",
     "assignedWarehouse":3,
     "password":"jkf",
     "firstName": "John",
     "lastName": "Doe",
     "profilePhoto": [-23,-34,56,78,78]
 }
 */
