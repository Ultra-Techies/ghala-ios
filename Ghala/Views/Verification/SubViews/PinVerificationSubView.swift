//
//  PinVerificationSubView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PinVerificationSubView: View {
    
    @ObservedObject var userService =  Service()
    
    @ObservedObject var user: User
    
    @State var code1: String
    @State var code2: String
    @State var code3: String
    @State var code4: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 80) {
            
            //MARK: -Code
           HStack(alignment: .center, spacing: 30) {
               TextField("", text: $code1)
                   .vCodeStyle()
               
               TextField("", text: $code2)
                   .vCodeStyle()
               
               TextField("", text: $code3)
                   .vCodeStyle()
               
               TextField("", text: $code4)
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
    }
    
    func checkPassword() async {
        do {
            let phone = user.phoneNumber
            print(phone)
            
            let arraryPass = [code1, code2, code3, code4]
            let joinedPassword = arraryPass.joined(separator: "")
            user.password = joinedPassword
            print("joined pin: \(user.password)")
            
            let access_token = try await userService.verifyUserLogin(user: user)
            print(access_token)
            
            
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
            debugPrint(error.localizedDescription)
            print(error.localizedDescription)
        }
    }
}

struct PinVerificationSubView_Previews: PreviewProvider {
    static var previews: some View {
       PinVerificationSubView(user: User(), code1: "1", code2: "2", code3: "3", code4: "4")
    }
}
