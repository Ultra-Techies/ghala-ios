//
//  AddWareHouse.swift
//  Ghala
//
//  Created by mroot on 21/05/2022.
//

import SwiftUI
import AlertToast

struct AddWareHouse: View {
    @Environment(\.dismiss) var dismiss //close view
    @StateObject var warehouseViewModel = WarehouseViewModel(wareHouseService: WareHouseService())
    @ObservedObject var warehouse: WareHouse
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Warehouse Name", text: $warehouse.name)
                }
                Section {
                    TextField("Location", text: $warehouse.location)
                }
            }
            //Add Button
            Button {
                Task {
                    await warehouseViewModel.addWareHouse(warehouse: warehouse)
                }
                dismiss()
            } label: {
                Text("ADD")
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
            }
            .background(Color.yellow).opacity(warehouseViewModel.isLoading ? 0 :  1)
            .overlay {
                ProgressView()
                    .opacity(warehouseViewModel.isLoading ? 1 : 0)
            }
            .padding()
            .navigationTitle("Add WareHouse")
        }
        .alert(warehouseViewModel.errorMsg, isPresented: $warehouseViewModel.showAlert) {}
        .toast(isPresenting: $warehouseViewModel.showToast, alert: {
            return AlertToast(type: .systemImage("checkmark", Color.yellow), title: "WareHouse Added")
            })
        
    }
}

struct AddWareHouse_Previews: PreviewProvider {
    static var previews: some View {
        AddWareHouse(warehouse: WareHouse())
    }
}
