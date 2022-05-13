//
//  enterOTP.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct enterOTP: View {
    
    @ObservedObject var userService = Service()
    @ObservedObject var userViewModel = UserViewModel(userService: Service())
    
    @ObservedObject var user : User
    @ObservedObject var otpCode: OTP
    
    
    var body: some View {
        NavigationView {
            
            Text(otpCode.otp)
            let _ = print(String(describing: "at view \(userService.otpCode.otp)"))
        }
        .task {
           await otpC()
        }

    }
    
    func otpC() async {
        do {
            
            user.phoneNumber = "+254748849086"
            try await userService.getOTP(user: user)
              print("code at view \(otpCode.otp)")
            
        } catch {
            print(error)
        }
        
        
//        do {
//            user.phoneNumber = "+254748849086"
//       let otp1 =  try await userService.getOTP2(user: user)
//
//            let otp = OTP(otp: otp1)
//
//           print( "is: \(otp)")
//           print(otp1)
//
//        } catch {
//            print(error)
//        }
        
    }
    
}

struct enterOTP_Previews: PreviewProvider {
    static var previews: some View {
        //enterOTP(user: User())
        enterOTP(user: User(), otpCode: OTP())
    }
}
