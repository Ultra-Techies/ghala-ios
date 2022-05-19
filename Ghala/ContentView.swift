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
            
            Text("Warehouse")
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Home")
            }
        }
        
        Text("Orders")
            .tabItem {
                Image(systemName: "shippingbox")
                Text("Home")
        }
        
        Text("Inventory")
            .tabItem {
                Image(systemName: "list.bullet.rectangle.fill")
                Text("Home")
        }
        
        Text("Dispatch")
            .tabItem {
                Image(systemName: "clock.fill")
                Text("Home")
        }
        
        Text("Settings")
            .tabItem {
                Image(systemName: "gear")
                Text("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User())
    }
}
