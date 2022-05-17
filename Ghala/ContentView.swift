//
//  ContentView.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userService = UserService()
    @ObservedObject var user : User
    @State var phone = ""
    @State var email = ""
    @State var firstname = ""
    @State var lastname = ""
    @State var warehouse: Int = 2
    
    
    var body: some View {
        
        VStack {
    
            
            TextField("Phone", text: $user.phoneNumber)
            Text(userService.otpCode.otp)
//            TextField("email", text: $user.email)
//            TextField("first name", text: $user.firstName)
//            TextField("last name", text: $user.lastName)
//            TextField("Ware House", value: $user.assignedWarehouse, formatter: NumberFormatter())
            
            Button {
                Task {
                   // try await userService.getOTP(user: user)
                   //try await userService.createUser(user: user)
                    //try await userService.checkIfUserExists(user: user)
                    try await userService.getAllUsers()
                }
            } label: {
                Text("Send")
            }

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User())
    }
}
