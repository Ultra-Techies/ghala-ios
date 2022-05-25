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
   // @Binding var showDrawerMenu: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
//                Button {
//                    self.showDrawerMenu = true
//                } label: {
//                    Image(systemName: "rectangle.grid.1x2")
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .foregroundColor(.black)
//                }
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
                .onAppear {
                    let p = user.phoneNumber
                    print(p)
                    Task {
                        try await userService.findByPhone(user:user)
                    }
                }
            Spacer()
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(user: User(), showDrawerMenu: true)
//    }
//}
