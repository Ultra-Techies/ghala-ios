//
//  OTPVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct OTPVerificationView: View {
    @ObservedObject var user : User
    var body: some View {
        GeometryReader { geo in
            VStack {
                TopInfoSubView(title: "OTP SMS", description: "Please enter the OTP code sent to your number")
                    .frame(height: geo.size.height * 0.6, alignment: .top)
                OTPCodeSubView(user: user)
                    .background(
                        RoundedCornersShape(corners: .topLeft, radius: 49)
                            .fill(Color.listBackground)
                    )
                   .offset(y: -50)
            }.background(Color.listBackground)
                .onTapGesture {
                    self.hideKeyboard()
                }
        }
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView(user: User())
    }
}
