//
//  PinVerificationSubView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PinVerificationSubView: View {
    
    @ObservedObject var userService =  UserService()
    
    @ObservedObject var user: User
    
    @State private var toHomeView = false
    
    @State var code1: String
    @State var code2: String
    @State var code3: String
    @State var code4: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 80) {
            
            //MARK: -Code
           HStack(alignment: .center, spacing: 30) {
               TextField("", text: $code1.max(1))
                   .vCodeStyle()
               
               TextField("", text: $code2.max(1))
                   .vCodeStyle()
               
               TextField("", text: $code3.max(1))
                   .vCodeStyle()
               
               TextField("", text: $code4.max(1))
                   .vCodeStyle()
           }
                .padding()
            
            VStack {
                
                Button  {
                    print("Login")
                
                    Task {
                        await checkPassword()
                    }
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.buttonColor)
            }
            //.padding(.top, 50)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.top, 100)
        
        .fullScreenCover(isPresented: $toHomeView) {
            HomeView(user: user)
        }
    }
    
    func checkPassword() async {
        do {
           
            let arraryPass = [code1, code2, code3, code4]
            let joinedPassword = arraryPass.joined(separator: "")
            user.password = joinedPassword
            
            let response = try await userService.verifyUserLogin(user: user)
            print("Status: \(response)")
            
            if response != 200 {
                print("Forbiden")
            } else {
                toHomeView.toggle()
            }
//            print("from service: \(pin)")
//
//            if pin == false {
//                print("password does not match")
//            } else {
//                print("to Home")
//            }
            
            //print("to Home")
//            else {
//                print("password match")
//            }
        
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct PinVerificationSubView_Previews: PreviewProvider {
    static var previews: some View {
       PinVerificationSubView(user: User(), code1: "1", code2: "2", code3: "3", code4: "4")
    }
}
