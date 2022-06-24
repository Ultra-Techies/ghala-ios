//
//  AddInventory.swift
//  Ghala
//
//  Created by mroot on 23/05/2022.
//

import SwiftUI

struct AddInventory: View {
    @Environment(\.dismiss) var dismiss //close view
    @StateObject var inventorViewModel = InventoryViewModel(inventoryService: InventoryService())
    @ObservedObject var inventory: Inventory
    var category = ["Sugar", "Flour", "Milk", "Cooking Oil", "Wheat Flour"]
    @State var selectCategory = 0
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Product Name")) {
                    TextField("", text: $inventory.name)
                }
                Section {
                    Picker(selection: $selectCategory, label: Text("Category")) {
                        ForEach(0 ..< category.count) {
                            Text(self.category[$0])
                        }
                    }
                }
                Section(header: Text("Price")) {
                    TextField("", value: $inventory.ppu, formatter: NumberFormatter())
                }
                Section (header: Text("Quantity")) {
                    TextField("", value: $inventory.quantity, formatter: NumberFormatter())
                }
            }
            //Add inventory Button
            Button {
                //Passing item category
                let categorySelected = category[selectCategory]
                inventory.category = categorySelected
                Task {
                    await inventorViewModel.addInventory(inventory:inventory)
                }
                dismiss()
            } label: {
                Text("ADD")
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
            }
            .background(Color.yellow).opacity(inventorViewModel.isLoading ? 0 :  1)
            .overlay {
                ProgressView()
                    .opacity(inventorViewModel.isLoading ? 1 : 0)
            }
            .padding()
            .navigationTitle("Add New Inventory")
        }.alert(inventorViewModel.errorMsg, isPresented: $inventorViewModel.showAlert) {}
    }
}

struct AddInventory_Previews: PreviewProvider {
    static var previews: some View {
        AddInventory(inventory: Inventory())
    }
}
