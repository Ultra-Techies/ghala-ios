//
//  SettingsView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var userService = UserService()
    @ObservedObject var user: User
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var pin = ""
    @State var verifyPin = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    TextField("First Name", text: $firstName)
                        .textFieldStyling()
                    TextField("Last Name", text: $lastName)
                        .textFieldStyling()
                    TextField("Email", text: $email)
                        .textFieldStyling()
                    TextField("PIN", text: $pin)
                        .textFieldStyling()
                    TextField("Verify Pin", text: $verifyPin)
                        .textFieldStyling()
                }
                .padding(.horizontal, 25.0)
                .padding(.top, 50)
                .padding(.bottom, 100)
                Button {
                    Task {
                      await update()
                    }
                    print("")
                } label: {
                    Text("UPDATE")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.buttonColor)
            }
            .navigationTitle("Settings")
        }
        .task {
           await getUser()
        }
    }
    func getUser() async {
        do {
            try await userService.getUser()
            firstName = userService.user.firstName
            lastName = userService.user.lastName
            email = userService.user.email
        } catch {
            print(error)
        }
    }
    func update() async {
        user.id = FromUserDefault.userID
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.password = pin
        do {
        try await userService.updateUser(user: user)
        } catch {
            print(error)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: User())
    }
}
