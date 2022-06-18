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
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }.onAppear {
            checkWareHouseId()
        }
        .fullScreenCover(isPresented: $toPhoneView) {
            PhoneInputSubView(user: User())
        }
        .accentColor(.yellow)
        .alert("No Warehouse Assigned!", isPresented: $showAlert) {
            Button("OK") {
                toPhoneView.toggle()
            }
        }
//            .alert(isPresented: $showAlert) {
//                Alert(
//                    title: Text("No Warahouse Assigned!!"),
//                    message: Text("Please contact you Admin to assign you a Warehouse."),
//                    primaryButton: .default(
//                                    Text("Try Again"),
//                                    action: checkWareHouseId
//                                ),
//                                secondaryButton: .destructive(
//                                    Text("Ok"),
//                                    action: toPhoneView
//                                )
//                    )
//            }
        if networkManager.isNotConnected {
            NetworkViewCell(netStatus: networkManager.conncetionDescription, image: networkManager.imageName)
        }
    }
    func checkWareHouseId() {
        var wareHouseID: Int? = nil
        wareHouseID = FromUserDefault.warehouseID
        print("Warehouse id: \(FromUserDefault.warehouseID)")
        if wareHouseID == 0 {
            showAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User())
    }
}
