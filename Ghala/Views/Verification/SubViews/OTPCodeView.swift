//
//  OTPCodeView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct OTPCodeView: View {
    
    @State var code1: Int
    @State var code2: Int
    @State var code3: Int
    @State var code4: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
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
            
            VStack(spacing: 20) {
                Text("Didn't receive an OTP?")
                    .foregroundColor(.gray)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                
                Button  {
                    print("resend OTP")
                } label: {
                    Text("Resend")
                        .font(.title3)
                        .underline()
                        .bold()
                        .foregroundColor(Color.buttonColor)
                }.buttonStyle(BorderlessButtonStyle())
                
                
                Button  {
                    print("Verify")
                } label: {
                    Text("Verify")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.buttonColor)
            } .padding(.top, 30)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.top, 100)
    }
}

struct OTPCodeView_Previews: PreviewProvider {
    static var previews: some View {
        OTPCodeView(code1: 1, code2: 2, code3: 3, code4: 4)
    }
}






                    //MARK: -Verification Code Text Styling
struct codeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .background(Color.gray).opacity(0.5)
            .multilineTextAlignment(.center)
            .cornerRadius(10)
    }
}

extension View {
    func vCodeStyle() -> some View {
        modifier(codeTextStyle())
    }
}
