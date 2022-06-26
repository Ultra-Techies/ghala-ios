//
//  PhoneVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI


struct PhoneVerificationView: View {
    @ObservedObject var networkManager = NetworkViewModel()
    var body: some View {
        VStack {
            TopInfoSubView(title: "Mobile Number", description: "We need to send an OTP to authenticate your number")
            LoginView()
                .background(
                    RoundedCornersShape(corners: .topLeft, radius: 90)
                        .fill(Color.listBackground)
                )
                .offset(y: -80)
            if networkManager.isNotConnected {
                NetworkViewCell(netStatus: networkManager.conncetionDescription, image: networkManager.imageName)
            }
        }.background(Color.listBackground)
    }
}


struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationView()
    }
}
