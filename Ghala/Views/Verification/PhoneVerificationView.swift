//
//  PhoneVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI


struct PhoneVerificationView: View {
    var body: some View {
        VStack {
            TopInfoSubView(title: "Mobile Number", description: "We need to send an OTP to authenticate your number")
            PhoneInputSubView(user: User())
                .background(
                    RoundedCornersShape(corners: .topLeft, radius: 90)
                        .fill(Color(UIColor.white))
                )
                .offset(y: -80)                
        }
    }
}


struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationView()
    }
}
