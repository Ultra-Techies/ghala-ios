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
    var category = ["Sugar", "Flour", "Milk", "Cooking Oil"]
    @State var selectCategory = 0
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Product Name")) {
                                    TextField("", text: $inventoryD.name)
                    }
                    Section {
                        Picker(selection: $selectCategory, label: Text("Category")) {
                            ForEach(0 ..< category.count) {
                                Text(self.category[$0])
                            }
                        }
                    }
                    Section(header: Text("Price")) {
                        TextField("", value: $inventoryD.ppu, formatter: NumberFormatter())
                    }
                    Section (header: Text("Quantity")) {
                        TextField("", value: $inventoryD.quantity, formatter: NumberFormatter())
                    }
                }
                //Add inventory Button
                Button {
                    Task {
                        await addInventoryItem()
                    }
                } label: {
                    Text("ADD")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.yellow)
                .padding()
            }
            .navigationTitle("Add New Inventory")
        }.onAppear {
            Task {
                try await userService.findByPhone(user: user)
            }
        }
    }
    
    //MARK: - Add Inventory
    private func addInventoryItem() async {
        do {
            //passing warehouseID from User
            let warehouseID = userService.us.assignedWarehouse
            print(warehouseID)
            let categorySelected = category[selectCategory]
            inventoryD.category = categorySelected
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
