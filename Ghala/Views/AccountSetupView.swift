//
//  AccountSetupView.swift
//  Ghala
//
//  Created by mroot on 14/05/2022.
//

import SwiftUI

struct AccountSetupView: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var wareHouse : Int = 1
    @State var accountPin = ""
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Setup your account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
            }
            .frame(maxWidth: .infinity, maxHeight: 50 , alignment: .center)
            .background(Color.yellow)
                
            
            
            Text("Welcome to Ghala. Please setup your account to start using the app")
                .padding(.horizontal, 25.0)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            VStack(spacing: 40) {
                TextField("First Name", text: $firstName)
                    .TextFieldStyling()
                TextField("Last Name", text: $lastName)
                    .TextFieldStyling()
                TextField("Email Address", text: $email )
                    .TextFieldStyling()
                TextField("Warehouse", value: $wareHouse, formatter: NumberFormatter())
                    .TextFieldStyling()
                TextField("Account PIN", text: $accountPin)
                    .TextFieldStyling()
                //TextField("Warehouse", value: $wareHouse, format: Formatter())
                
            }
            .padding(.horizontal, 25.0)
            .padding(.top, 50)
            .padding(.bottom, 100)
            Button  {
                print("Verify Details")
            } label: {
                Text("Verify")
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
            }
            .background(Color.buttonColor)

            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView()
    }
}


//MARK: -Text Field Styling
struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(maxWidth: .infinity)
        .overlay(VStack{Divider().frame(height: 2).background(Color.buttonColor).offset(x: 0, y: 15)})
    }
}

extension View {
    func TextFieldStyling() -> some View {
        modifier(TextFieldStyle())
    }
}

