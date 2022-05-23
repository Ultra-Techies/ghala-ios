//
//  InventoryView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct InventoryView: View {
    @ObservedObject var inventoryService = InventoryService()
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Filter
                HStack {
                    Image("filter")
                    Text("Filter")
                    Spacer()
                    Text("Category:")
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 11, height: 11)
                }.padding(.horizontal, 10)
                    .padding(.top, 10)
                
                //Inventory List
                List {
                    ForEach(inventoryService.inventory, id: \.sku) { inventoryItem in
                        InventoryCell(name: inventoryItem.name, Category: inventoryItem.category, SKU: inventoryItem.skuCode, price: inventoryItem.ppu, quantity: inventoryItem.quantity, status: inventoryItem.status)
                    }
                }
                .refreshable {
                    Task {
                        await getAll()
                    }
                }
            }.navigationTitle("Inventory")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "magnifyingglass")
                    }
                }
        }.task {
            await getAll()
        }
    }
    //getAllItems
    func getAll() async {
        do {
            try await inventoryService.getAllInventory()
        } catch {
            print(error)
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
    }
}
