//
//  MainView.swift
//  Ghala
//
//  Created by mroot on 15/05/2022.
//

import SwiftUI

struct HomeUserCell: View {
    @StateObject var userViewModel = UserViewModel(userService: UserService())
    @ObservedObject var user: User
    @State private var toLogin = false
    @State private var showAlert = false
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Hello,")
                        .fontWeight(.light)
                    Text("\(userViewModel.user.firstName) \(userViewModel.user.lastName)")
                        .bold()
                    let _ = print("UserDetails: \(userViewModel.user.firstName)")
                }
                Spacer()
                Button {
                    let domain = String(describing: FromUserDefault.warehouseID)
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                    URLCache.shared.removeAllCachedResponses()
                    showAlert = true
                } label: {
                    Text("Logout")
                        .bold()
                }
            } .padding(.horizontal, 20)
                .padding(.top, 20)
        }.onAppear {
            Task {
                await userViewModel.findByPhoneNumber(user: user)
            }
        }
        .fullScreenCover(isPresented: $toLogin) {
            LoginView()
        }
        // MARK: Logout Alert
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Logout!!"),
                message: Text("Are you sure you want to logout?"),
                primaryButton: .default(
                    Text("Cancel")
                ),
                secondaryButton: .destructive(Text("Logout"), action: {
                URLCache.shared.removeAllCachedResponses()
                toLogin.toggle()
            }))
        }
    }
}

struct HomeUserCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeUserCell(user: User())
    }
}
