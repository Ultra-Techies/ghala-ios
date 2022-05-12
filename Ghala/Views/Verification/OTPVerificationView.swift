//
//  OTPVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct OTPVerificationView: View {
    var body: some View {
        TopInfoView(title: "OTP SMS", description: "Please enter the OTP code sent to your number")
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OTPVerificationView()
            OTPCodeView(code1: 1, code2: 2, code3: 3, code4: 4)
                .background(
                    RoundedCornersShape(corners: .topLeft, radius: 90)
                        .fill(Color(UIColor.white))
                )
                .offset(y: -80)
        }
    }
}
