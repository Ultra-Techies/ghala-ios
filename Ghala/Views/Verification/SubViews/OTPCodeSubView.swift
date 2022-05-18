//
//  OTPCodeView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI
import UIKit
import Combine

struct OTPCodeSubView: View {
    
    
    enum CodeError: Error {
        case noOTPError
    }
    
    @ObservedObject var userService = UserService()
    
    @ObservedObject var user : User
    @ObservedObject var otpCode : OTP
    
    
    @State var code1: String
    @State var code2: String
    @State var code3: String
    @State var code4: String
    
    
    
    @State private var isPin1FirstResponder: Bool? = true
    @State private var isPin2FirstResponder: Bool? = false
    @State private var isPin3FirstResponder: Bool? = false
    @State private var isPin4FirstResponder: Bool? = false
    
    @State private var toAccSetup = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            //MARK: -Code
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
            
            VStack(spacing: 20) {
                Text("Didn't receive an OTP?")
                    .foregroundColor(.gray)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                
                let _ = print(String(describing: "OTP is on OTP Screen:  \(userService.otpCode.otp)"))
                
                Button  {
                    Task {
                        await getOTP()
                    }
                } label: {
                    Text("Resend")
                        .font(.title3)
                        .underline()
                        .bold()
                        .foregroundColor(Color.buttonColor)
                }.buttonStyle(BorderlessButtonStyle())
                
                
                Button  {

                    let userOTPCode = "\(self.code1)\(self.code2)\(self.code3)\(self.code4)"
                    print(userOTPCode)
                    
                let code = userService.otpCode.otp
                    
                if  userOTPCode != code {
                    print("not same")
                } else {
                    toAccSetup.toggle()
                    print("Same!!! to create account")
                }
                    
                } label: {
                    Text("Verify")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.buttonColor)
            } .padding(.top, 30)
            
            .fullScreenCover(isPresented: $toAccSetup) {
                AccountSetupView(user: user)
            }
        }
        .onAppear {
            Task {
                //print("phone number: \(user.phoneNumber)")
                await getOTP()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.top, 100)
    }
    
    func getOTP() async {
        
        do {

            try await userService.getOTP(user: user)
           print(otpCode)
            
        } catch {
            print(error)
            debugPrint(error)
        }
    }
}

struct OTPCodeView_Previews: PreviewProvider {
    static var previews: some View {
        OTPCodeSubView(user: User(), otpCode: OTP(), code1: "1", code2: "2", code3: "3", code4: "4")
    }
}


                    //MARK: -Verification Code Text Styling
struct codeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .background(Color.gray).opacity(0.5)
            .multilineTextAlignment(.center)
            .cornerRadius(10)
            .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func vCodeStyle() -> some View {
        modifier(codeTextStyle())
    }
}
