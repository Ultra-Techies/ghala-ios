//
//  PinVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PinVerificationView: View {
    var body: some View {
        VStack {
            TopInfoSubView(title: "Enter Pin", description: "Please enter your account pin or passcode")
            PinVerificationSubView(code1: 1, code2: 2, code3: 3, code4: 4)
                .background(
                    RoundedCornersShape(corners: .topLeft, radius: 90)
                        .fill(Color(UIColor.white))
                )
                .offset(y: -80)
        }.background(.white)
    }
}

struct PinVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PinVerificationView()
    }
}
