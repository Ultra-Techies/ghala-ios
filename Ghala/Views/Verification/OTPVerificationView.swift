//
//  OTPVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct OTPVerificationView: View {
    @ObservedObject var userService = Service()
    @ObservedObject var user : User
    
    var body: some View {
        NavigationView {
            VStack {
                TopInfoSubView(title: "OTP SMS", description: "Please enter the OTP code sent to your number")
                OTPCodeSubView(user: user, otpCode: OTP(), code1: "", code2: "", code3: "", code4: "")
                    .background(
                        RoundedCornersShape(corners: .topLeft, radius: 90)
                            .fill(Color(UIColor.white))
                    )
                    .offset(y: -80)
            }
        }

    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView(user: User())
    }
}
