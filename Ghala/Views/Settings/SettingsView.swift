//
//  SettingsView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var userService = UserService()
    @State var firstName = ""
    @State var lasttName = ""
    @State var email = ""
    @State var pin = ""
    @State var verifyPin = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    TextField("",text: $userService.userID.firstName)
                        .textFieldStyling()
                    TextField("",text: $userService.userID.lastName)
                        .textFieldStyling()
                    TextField("",text: $userService.userID.email)
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
        }catch {
            print(error)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
