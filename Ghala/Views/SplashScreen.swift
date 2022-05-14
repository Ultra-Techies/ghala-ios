//
//  SplashScreen.swift
//  Ghala
//
//  Created by mroot on 13/05/2022.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    
    var body: some View {
        if isActive {
            PhoneVerificationView()
        } else {
            VStack {
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    Text("Ghala")
                        .fontWeight(.bold)
                        .font(.system(size: 38))
                        .padding(.bottom, 50)

                    Spacer()
                        ProgressView()
                            .scaleEffect(2)
                            .font(.system(size:8))
                            .frame(alignment: .bottom)
                            .padding()
                            .padding(.bottom, 60)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow)
            } .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
