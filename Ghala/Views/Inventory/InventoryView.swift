//
//  InventoryView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct InventoryView: View {
    @StateObject var inventoryViewModel = InventoryViewModel(inventoryService: InventoryService())
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(inventoryViewModel.inventorySearch, id: \.sku) { inventory in
                            InventoryCell(name: inventory.name, category: inventory.category, SKU: inventory.skuCode, price: inventory.ppu, quantity: inventory.quantity, status: inventory.status)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }
                        .listRowBackground(Color.clear)
                        .background(Color.listBackground)
                    }
                    .listStyle(SidebarListStyle())
                    .navigationTitle("Inventory")
                    .searchable(text: $inventoryViewModel.searchInventory, prompt: "Search Inventory")
                    .refreshable {
                        Task {
                            await inventoryViewModel.getInventory()
                        }
                    }
                }
                // MARK: Add Inventory Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        // MARK: Add WareHouse Button
                        NavigationLink(destination: AddInventory(inventory: Inventory())) {
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
            await inventoryViewModel.getInventory()
        }
        .alert(inventoryViewModel.errorMsg, isPresented: $inventoryViewModel.showAlert) {}
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
    }
}
