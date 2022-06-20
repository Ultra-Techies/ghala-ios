//
//  SettingsView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI
import AlertToast

struct SettingsView: View {
    @ObservedObject var userService = UserService()
    @ObservedObject var user: User
    @State private var showToast = false
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var pin = ""
    @State var verifyPin = ""
    
    @State var showAlert: Bool = false
    @State var errorMsg: String = ""
    @State var loading: Bool = false
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
                } label: {
                    Text("UPDATE")
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(width: 350, height: 50)
                .background(Color.buttonColor).opacity(loading ? 0 :  1)
                .background(
                    Rectangle()
                        .fill(Color.buttonColor)
                        .opacity(loading ? 0 : 1)
                )
                .overlay {
                    ProgressView()
                        .opacity(loading ? 1 : 0)
                }
            }
            .navigationTitle("Settings")
        }.alert(errorMsg, isPresented: $showAlert) {}
            .toast(isPresenting: $showToast, alert: {
                AlertToast(type: .regular, title: "Updated Successfully")
            })
        .task {
           await getUser()
        }
    }
    // MARK: Fetch user Details
    func getUser() async {
        do {
            try await userService.getUser()
            firstName = userService.user.firstName
            lastName = userService.user.lastName
            email = userService.user.email
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Update
    func update() async {
        user.id = FromUserDefault.userID
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.password = pin
        do {
            loading = true
        try await userService.updateUser(user: user)
            showToast = true
        } catch {
            loading = false
            handleError(error: error.localizedDescription)
        }
        loading = false
    }
    // MARK: Alert
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.loading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: User())
    }
}
