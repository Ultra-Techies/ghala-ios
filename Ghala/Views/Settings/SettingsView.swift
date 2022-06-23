//
//  SettingsView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI
import AlertToast

struct SettingsView: View {
    @StateObject var userViewModel = UserViewModel(userService: UserService())
    @ObservedObject var user: User
    @State private var showToast = false
    @State var pin = ""
    @State var verifyPin = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    TextField("First Name", text: $userViewModel.user.firstName)
                        .textFieldStyling()
                    TextField("Last Name", text: $userViewModel.user.lastName)
                        .textFieldStyling()
                    TextField("Email", text: $userViewModel.user.email)
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
                .background(Color.buttonColor).opacity(userViewModel.isLoading ? 0 :  1)
                .background(
                    Rectangle()
                        .fill(Color.buttonColor)
                        .opacity(userViewModel.isLoading ? 0 : 1)
                )
                .overlay {
                    ProgressView()
                        .opacity(userViewModel.isLoading ? 1 : 0)
                }
            }
            .navigationTitle("Settings")
        }
        .alert(userViewModel.errorMsg, isPresented: $userViewModel.showAlert) {}
        .toast(isPresenting: $showToast, alert: {
                AlertToast(type: .regular, title: "Updated Successfully")
            })
        .task {
            await userViewModel.findByPhoneNumber(user: user)
        }

    }
    // MARK: Update
    func update() async {
        userViewModel.user.password = pin
        await userViewModel.updateUser(user: userViewModel.user)
        showToast = true
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: User())
    }
}
