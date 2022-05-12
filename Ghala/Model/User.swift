//
//  User.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import Foundation

class User: Codable, ObservableObject, Identifiable {
    
    enum CodingKeys: CodingKey{
            case phoneNumber, email, assignedWarehouse, firstName, lastName
            
        }
      
        @Published var phoneNumber = ""
        @Published var email = ""
        @Published var assignedWarehouse: Int = 1
        @Published var firstName = ""
        @Published var lastName = ""
        
        init() {
            
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
        
            phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
            email = try container.decode(String.self, forKey: .email)
            assignedWarehouse = try container.decode(Int.self, forKey: .assignedWarehouse)
            firstName = try container.decode(String.self, forKey: .firstName)
            lastName = try container.decode(String.self, forKey: .lastName)
          
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(phoneNumber, forKey: .phoneNumber)
            try container.encode(email, forKey: .email)
            try container.encode(assignedWarehouse, forKey: .assignedWarehouse)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
        }

    
}

struct check: Codable {
    let exists: Bool
   // let otp: String
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
