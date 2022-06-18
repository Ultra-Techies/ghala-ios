//
//  MainView.swift
//  Ghala
//
//  Created by mroot on 15/05/2022.
//

import SwiftUI

struct HomeUserCell: View {
    @ObservedObject var user: User
    @ObservedObject var userService =  UserService()
    @State private var toPhoneView = false
    var body: some View {
        //User Details (Photo, Full Names)
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Hello,")
                        .fontWeight(.light)
                    Text("\(userService.us.firstName) \(userService.us.lastName)")
                        .bold()
                    let _ = print("UserDetails: \(userService.us.firstName)")
                }
                Spacer()
                Button("Logout") {
                   // UserDefaults.registrationDomain
                    UserDefaults.standard.removeObject(forKey: "warehouse_Id")
                    toPhoneView = true
                }
            } .padding(.horizontal, 20)
        } .task {
            await findUserDetails()
        }
        .fullScreenCover(isPresented: $toPhoneView) {
            PhoneInputSubView(user: User())
        }
    }
    func findUserDetails() async {
        do {
            try await userService.findByPhone(user: user)
        } catch {
            print(error)
        }
    }
}
