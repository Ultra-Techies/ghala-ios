//
//  OTPCodeView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct OTPCodeSubView: View {
    
    
    enum CodeError: Error {
        case noOTPError
    }
    
    @ObservedObject var userViewModel = UserViewModel(userService: Service())
    
    @ObservedObject var userService = Service()
    @ObservedObject var user : User
    @ObservedObject var otpCode : OTP
    
    
    @State var code1: String
    @State var code2: String
    @State var code3: String
    @State var code4: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
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
            
            VStack(spacing: 20) {
                Text("Didn't receive an OTP?")
                    .foregroundColor(.gray)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                
                
                let _ = print(String(describing: "at view OTP VIEW \(userService.otpCode.otp)"))
                
                Button  {
                    print("resend OTP")
                } label: {
                    Text("Resend")
                        .font(.title3)
                        .underline()
                        .bold()
                        .foregroundColor(Color.buttonColor)
                }.buttonStyle(BorderlessButtonStyle())
                
              //  Text(otp.otp)
                
                Button  {

                let arrayCode = [code1, code2, code3, code4]
                let join = arrayCode.joined(separator: "")
                    
                let code = userService.otpCode.otp
                    
                if code != join {
                print("not same")
                } else {
                print("Same!!! to create account")
                }
                    
                    print("Verify")
                } label: {
                    Text("Verify")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.buttonColor)
            } .padding(.top, 30)
        }
        .onAppear {
            Task {
                print("phone number: \(user.phoneNumber)")
                await getOTP()
            }
        }
//        .task {
//            print("phone number: \(user.phoneNumber)")
//            await getOTP()
//
//        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.top, 100)
    }
    
    func getOTP() async {
        
//       let otpCode = try? await userService.getOTP(user: user)
//        print("code is: \(otpCode)")
        do {
            //let otpCode = try await userViewModel.getOTPCode(user: user)
            try await userService.getOTP(user: user)
           print(otpCode)
            
//            // codes from view
//            let arrayCode = [code1, code2, code3, code4]
//            let join = arrayCode.joined(separator: "")
//            print(join)
//
//            if otpCode != join {
//                print("not same")
//            } else {
//                print("to create account")
//            }
            
        } catch {
            print(error)
            debugPrint(error)
        }
    }
}

struct OTPCodeView_Previews: PreviewProvider {
    static var previews: some View {
        //OTPCodeSubView(user: User(), code1: "1", code2: "2", code3: "3", code4: "4")
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
    }
}

extension View {
    func vCodeStyle() -> some View {
        modifier(codeTextStyle())
    }
}
