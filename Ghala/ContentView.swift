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
    @ObservedObject var userService =  UserService()
    @State private var showAlert = false
    @State private var toPhoneView = false
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
            SettingsView(user: User())
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }.onAppear {
            Task {
                await findUserDetails()
            }
        }
        .fullScreenCover(isPresented: $toPhoneView) {
            LoginView()
        }
        .accentColor(.yellow)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("No Warehouse Assigned!"), message: Text("Please contact your Admin to assign you a Warehouse."), dismissButton: .destructive(Text("OK"), action: {
                URLCache.shared.removeAllCachedResponses()
                toPhoneView.toggle()
            }))
        }
        if networkManager.isNotConnected {
            NetworkViewCell(netStatus: networkManager.conncetionDescription, image: networkManager.imageName)
        }
    }
    func checkWareHouseId() {
        let wareHouseId = userService.us.assignedWarehouse
        print("Warehouse at Home: \(wareHouseId)")
        if wareHouseId == 0 {
            showAlert = true
        }
    }
    func findUserDetails() async {
        do {
            try await userService.findByPhone(user: user)
            checkWareHouseId()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User())
    }
}
