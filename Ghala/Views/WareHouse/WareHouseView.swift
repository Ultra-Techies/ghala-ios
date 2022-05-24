//
//  WareHouseView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct WareHouseView: View {
    @ObservedObject var wareHouseService = WareHouseService()
   
    var body: some View {
        NavigationView {
           ZStack {
               VStack {
                List {
                    ForEach(wareHouseService.warehouse, id: \.id) { ware in
                        WarehouseCell(name: ware.name, location: ware.location)
                            .listRowSeparator(.hidden)
                    }
                }.listStyle(PlainListStyle())
                .navigationTitle("Warehouses")
                .refreshable {
                    Task {
                        await getWareHouses() //swipe down to refresh
                    }
                }
            }
               VStack {
                   Spacer()
                   HStack {
                       Spacer()
                       //to Add WareHouse
                       NavigationLink(destination: AddWareHouse(warehouse: WareHouse())) {
                           Image(systemName: "plus.circle.fill")
                               .resizable()
                               .frame(width: 50, height: 50)
                               .foregroundColor(.yellow)
                               .padding()
                       }
                   }
               }
           }
                //search
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "magnifyingglass")
                    }
                }
        }
        .task {
           await getWareHouses()
        }
    }
    
    func getWareHouses() async {
        do {
            try await wareHouseService.getAllWareHouse()
        } catch {
            print(error)
        }
    }
}

struct WareHouseView_Previews: PreviewProvider {
    static var previews: some View {
        WareHouseView()
    }
}
