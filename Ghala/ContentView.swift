//
//  ContentView.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import SwiftUI

struct ContentView: View {
    
   // @ObservedObject var userService = UserService()
    @ObservedObject var user: User
    
    var body: some View {
        TabView {
            HomeView(user: user)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
            }
            WareHouseView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("WareHouse")
            }
            OrderView()
                .tabItem {
                    Image(systemName: "shippingbox")
                    Text("Order")
            }
            InventoryView(user: user)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Inventory")
            }
            DispatchView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Dispatch")
            }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }.accentColor(.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User())
    }
}
