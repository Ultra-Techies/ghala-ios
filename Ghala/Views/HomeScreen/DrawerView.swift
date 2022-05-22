//
//  DrawerView.swift
//  Ghala
//
//  Created by mroot on 15/05/2022.
//

import SwiftUI

struct DrawerView: View {
    @ObservedObject var user: User
    @ObservedObject var userService =  UserService()
    @State private var toWareHouse = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 10) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 80, height: 80)
               // let joinedName = user.firstName + " " + user.lastName
                Text("\(userService.us.firstName) \(userService.us.lastName)")
                    .bold()
                Text(userService.us.email)
                    
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity)
            .background(Color.yellow)
            //MARK: Drawer Views
            VStack(alignment: .leading, spacing: 40) {
                    Button {
                        print("Home")
                    } label: {
                    Image(systemName: "house.fill")
                        .resizable()
                        .drawerHStyle()
                    Text("Home")
                    }.foregroundColor(.black)
                    Button {
                        print("WareHouse")
                    } label: {
                        Image(systemName: "note.text")
                            .resizable()
                            .drawerHStyle()
                        Text("Warehouse")
                    }.foregroundColor(.black)
                    Button {
                        print("Orders")
                    } label: {
                        Image(systemName: "shippingbox")
                            .resizable()
                            .drawerHStyle()
                        Text("Orders")
                    }.foregroundColor(.black)
                    Button {
                        print("Inventory")
                    } label: {
                        Image(systemName: "list.bullet.rectangle.fill")
                            .resizable()
                            .drawerHStyle()
                        Text("Inventory")
                    }.foregroundColor(.black)
                Button {
                    print("Dispatch")
                } label: {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .drawerHStyle()
                    Text("Dispatch")
                }.foregroundColor(.black)
                Button {
                    print("Settings")
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .drawerHStyle()
                    Text("Settings")
                }.foregroundColor(.black)
            } .padding()
                .padding(.top, 30)
            Spacer()
        }.onAppear {
            Task {
                try await userService.findByPhone(user: user)
            }
        }
        fullScreenCover(isPresented: $toWareHouse) {
            WareHouseView()
        }
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(user: User())
    }
}

struct drawerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 35, height: 35)
            .padding(.trailing, 10)
    }
}

extension View {
    func drawerHStyle() -> some View {
        modifier(drawerStyle())
    }
}
