//
//  ContentView.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkViewModel()
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
            OrderView(orderDelivery: OrderElementForDelivery())
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
        if networkManager.isNotConnected {
            NetworkViewCell(netStatus: networkManager.conncetionDescription, image: networkManager.imageName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User())
    }
}
