//
//  numberOtp.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//
//
//import SwiftUI
//
//struct numberOtp: View {
//    
//    
//    @StateObject var users = UserViewModel(userService: UserService())
//    
//    @State var phone = ""
//    
//    var user: User
//    
//    
//    var body: some View {
//        VStack {
//            TextField("phone", text: $phone)
//            Button {
//                Task {
//                    await users.checkUserExist(user: user)
//                }
//            } label: {
//                Text("check")
//            }
//
//        }
//        onAppear {
//            phone = user.phoneNumber
//        }
//    }
//}
//
//struct numberOtp_Previews: PreviewProvider {
//    static var previews: some View {
//        numberOtp(user: User(phoneNumber: ""))
//    }
//}
