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
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 120, height: 120)
                //.font(.system(size: 100))
            
            Text("Ghala")
                .fontWeight(.bold)
                .font(.system(size: 38))
                .padding(.bottom, 50)

                ProgressView()

                    .scaleEffect(2)
                    .font(.system(size:8))
                    .frame(alignment: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
