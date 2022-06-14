//
//  WareHouseView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct WareHouseView: View {
    @ObservedObject var wareHouseService = WareHouseService()
    @State var searchWarehouse = ""
    var body: some View {
        NavigationView {
           ZStack {
               VStack {
                List {
                    ForEach(wareHouseSearch, id: \.id) { wHouse in
                        WarehouseCell(name: wHouse.name, location: wHouse.location)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }
                    .listRowBackground(Color.clear)
                    .background(Color.listBackground)
                }.listStyle(SidebarListStyle())
                .navigationTitle("Warehouses")
                .searchable(text: $searchWarehouse, prompt: "Search Warehouse")
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
                       // MARK: Add WareHouse Button
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
        }
    }
    
    // MARK: Search Warehouse
    var wareHouseSearch: [WarehouseElement1] {
        // MARK: TO-DO (Handle Concurrency here!!!)
        Task.detached {
            await getWareHouses()
        }
        if searchWarehouse.isEmpty {
            //print("First return: \(wareHouseService.warehouse)")
            return wareHouseService.warehouse.reversed()
        } else {
            //print("WareHouse: \(wareHouseService.warehouse)")
            
            return wareHouseService.warehouse.filter { $0.name.localizedCaseInsensitiveContains(searchWarehouse)}
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
