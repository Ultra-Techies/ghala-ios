//
//  PinVerificationSubView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PinVerificationSubView: View {
    
    @State var code1: Int
    @State var code2: Int
    @State var code3: Int
    @State var code4: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 80) {
            
            //MARK: -Code
           HStack(alignment: .center, spacing: 30) {
               TextField("", value: $code1, formatter: NumberFormatter())
                   .vCodeStyle()
               
               TextField("", value: $code2, formatter: NumberFormatter())
                   .vCodeStyle()
               
               TextField("", value: $code3, formatter: NumberFormatter())
                   .vCodeStyle()
               
               TextField("", value: $code4, formatter: NumberFormatter())
                   .vCodeStyle()
           }
                .padding()
            
            VStack {
                
                Button  {
                    print("Login")
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.buttonColor)
            }
            //.padding(.top, 50)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.top, 100)
    }
}

struct PinVerificationSubView_Previews: PreviewProvider {
    static var previews: some View {
        PinVerificationSubView(code1: 1, code2: 2, code3: 3, code4: 4)
    }
}
