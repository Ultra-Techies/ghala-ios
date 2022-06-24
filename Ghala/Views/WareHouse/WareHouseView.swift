//
//  WareHouseView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct WareHouseView: View {
    @StateObject var warehouseViewModel = WarehouseViewModel(wareHouseService: WareHouseService())
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(warehouseViewModel.wareHouseSearch, id: \.id) { warehouse in
                            WarehouseCell(name: warehouse.name, location: warehouse.location)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }
                        .listRowBackground(Color.clear)
                        .background(Color.listBackground)
                    }
                    .listStyle(SidebarListStyle())
                    .navigationTitle("Warehouses")
                    .searchable(text: $warehouseViewModel.searchWareHouse, prompt: "Search Warehouse")
                    .refreshable {
                        Task {
                            await warehouseViewModel.getAll() //swipe down to refresh
                        }
                    }
                }
                // MARK: Add WareHouse Button
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
        }.task {
            await warehouseViewModel.getAll()
        }
    }
}

struct WareHouseView_Previews: PreviewProvider {
    static var previews: some View {
        WareHouseView()
    }
}
