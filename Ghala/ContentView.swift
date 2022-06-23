//
//  ContentView.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkViewModel()
    @StateObject var userViewModel = UserViewModel(userService: UserService())
    @ObservedObject var user: User
    @State private var toLogin = false
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
            SettingsView(user: user)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }.onAppear {
            Task {
                await getUserDetails()
            }
        }
        .fullScreenCover(isPresented: $toLogin) {
            LoginView()
        }
        .accentColor(.yellow)
        .alert(isPresented: $userViewModel.showAlert) {
            Alert(title: Text("No Warehouse Assigned!"), message: Text("Please contact your Admin to assign you a Warehouse."), dismissButton: .destructive(Text("OK"), action: {
                URLCache.shared.removeAllCachedResponses()
                toLogin.toggle()
            }))
        }
        if networkManager.isNotConnected {
            NetworkViewCell(netStatus: networkManager.conncetionDescription, image: networkManager.imageName)
        }
    }
    func getUserDetails() async {
        let number = user.phoneNumber
        print("User number: \(number)")
        await userViewModel.findByPhoneNumber(user:user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User())
    }
}
