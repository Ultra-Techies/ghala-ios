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
        GeometryReader { geo in
            VStack {
                TopInfoSubView(title: "Enter Pin", description: "Please enter your account pin or passcode")
                    .frame(height: geo.size.height * 0.65, alignment: .top)
                PinVerificationSubView(user: user)
                    .background(
                        RoundedCornersShape(corners: .topLeft, radius: 60)
                            .fill(Color.listBackground)
                    )
                    .offset(y: -87)
            }.background(Color.listBackground)
                .onTapGesture {
                    self.hideKeyboard()
                }
        }
    }
}

struct PinVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PinVerificationView(user: User())
    }
}
