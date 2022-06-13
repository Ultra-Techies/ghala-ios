//
//  PinVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PinVerificationView: View {
    @ObservedObject var user : User
    var body: some View {
        VStack {
            TopInfoSubView(title: "Enter Pin", description: "Please enter your account pin or passcode")
            PinVerificationSubView(user: user, code1: "", code2: "", code3: "", code4: "")
                .background(
                    RoundedCornersShape(corners: .topLeft, radius: 90)
                        .fill(Color(UIColor.white))
                )
                .offset(y: -87)
        }.background(.white)
    }
}

struct PinVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PinVerificationView(user: User())
    }
}
