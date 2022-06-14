//
//  AccountSetupView.swift
//  Ghala
//
//  Created by mroot on 14/05/2022.
//

import SwiftUI

struct AccountSetupView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var user : User
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var accountPin = ""
    @State private var toAccSetup = false
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
                let _ = print(String(describing: user.phoneNumber))
                TextField("First Name", text: $user.firstName)
                    .textFieldStyling()
                TextField("Last Name", text: $user.lastName)
                    .textFieldStyling()
                TextField("Email Address", text: $user.email )
                    .textFieldStyling()
                SecureField("Account Pin",text: $user.password)
                    .textFieldStyling()
                    .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
            }
            .padding(.horizontal, 25.0)
            .padding(.top, 50)
            .padding(.bottom, 100)
            Button {
                toAccSetup.toggle()
            } label: {
                Text("VERIFY")
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
            }
            .background(Color.buttonColor)
            // MARK: Add condion when button pressed wait for...  ---on (Environment dismiss)
//            ProgressView()
//                .scaleEffect(2)
//                .font(.system(size:8))
//                .frame(alignment: .bottom)
//                .padding(.top, 50)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .fullScreenCover(isPresented: $toAccSetup) {
           SubmittedSucessScreen(user: user)
        }
        
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView(user: User())
    }
}

// MARK: - Text Field Styling
struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(maxWidth: .infinity)
        .overlay(VStack{Divider().frame(height: 2).background(Color.buttonColor).offset(x: 0, y: 15)})
    }
}

extension View {
    func textFieldStyling() -> some View {
        modifier(TextFieldStyle())
    }
}
