//
//  AddInventory.swift
//  Ghala
//
//  Created by mroot on 23/05/2022.
//

import SwiftUI

struct AddInventory: View {
    @ObservedObject var inventoryService = InventoryService()
    @ObservedObject var userService = UserService()
    @ObservedObject var inventoryD: InventoryEncode
    @ObservedObject var user: User
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Product Name", text: $inventoryD.name)
            TextField("Product Category", text: $inventoryD.category) //To-Do add Picker
            TextField("Price Per Unit", value: $inventoryD.ppu, formatter: NumberFormatter())
            TextField("Quantity", value: $inventoryD.quantity, formatter: NumberFormatter())
            //Add Item
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            Task {
                                await addInventoryItem()
                            }
                        } label: {
                            Text("Add")
                        }
                    }
                }
        }.onAppear {
            Task {
                try await userService.findByPhone(user:user)
            }
        }
    }
    //add Inventory
    private func addInventoryItem() async {
        do {
            //passing warehouseID from User
            let warehouseID = userService.us.assignedWarehouse
            print(warehouseID)
            inventoryD.warehouseId = warehouseID
            try await inventoryService.addInventory(inventory: inventoryD)
        } catch {
            print(error)
        }
    }
}

struct AddInventory_Previews: PreviewProvider {
    static var previews: some View {
        AddInventory(inventoryD: InventoryEncode(), user: User())
    }
}
