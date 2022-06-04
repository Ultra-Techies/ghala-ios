//
//  MainView.swift
//  Ghala
//
//  Created by mroot on 15/05/2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var user: User
    @ObservedObject var userService =  UserService()
    var body: some View {
        //User Details (Photo, Full Names)
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.padding(.horizontal, 20)
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Hello,")
                        .fontWeight(.light)
                    Text("\(userService.us.firstName) \(userService.us.lastName)")
                        .bold()
                }
            } .padding(.horizontal, 20)
        } .task {
            await findUserDetails()
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

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(user: User(), showDrawerMenu: true)
//    }
//}
