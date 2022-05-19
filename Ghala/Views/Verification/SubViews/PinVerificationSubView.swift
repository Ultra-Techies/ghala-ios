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
    
    
    @State private var isPin1FirstResponder: Bool? = true
    @State private var isPin2FirstResponder: Bool? = false
    @State private var isPin3FirstResponder: Bool? = false
    @State private var isPin4FirstResponder: Bool? = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 80) {
            
            //MARK: -PIN
            HStack {
                Group {
                    CodeTextField(text: self.$code1,
                                    nextResponder: self.$isPin2FirstResponder,
                                    isResponder: self.$isPin1FirstResponder, previousResponder: .constant(nil))
                    
                    CodeTextField(text: self.$code2,
                                    nextResponder: self.$isPin3FirstResponder,
                                    isResponder: self.$isPin2FirstResponder, previousResponder: self.$isPin1FirstResponder)
                    
                    CodeTextField(text: self.$code3,
                                    nextResponder: self.$isPin4FirstResponder,
                                    isResponder: self.$isPin3FirstResponder, previousResponder: self.$isPin2FirstResponder)
                    
                    CodeTextField(text: self.$code4,
                                    nextResponder: .constant(nil),
                                    isResponder: self.$isPin4FirstResponder, previousResponder: self.$isPin3FirstResponder)
                    
                }
                .vCodeStyle()
            }.padding()
            
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
            let pin = "\(self.code1)\(self.code2)\(self.code3)\(self.code4)"
            print(pin)
            user.password = pin
            
            let response = try await userService.verifyUserLogin(user: user)
            print("Status: \(response)")
            
            if response != 200 {
                print("Forbiden")
            } else {
                try await userService.findByPhone(user: user)
                toHomeView.toggle()
            }
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
