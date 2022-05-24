//
//  AddWareHouse.swift
//  Ghala
//
//  Created by mroot on 21/05/2022.
//

import SwiftUI

struct AddWareHouse: View {
    @ObservedObject private var wareHouseService = WareHouseService()
    @ObservedObject var warehouse: WareHouse
    
    var body: some View {
        NavigationView {
            
//            VStack {
//                TextField("Warehouse Name", text: $warehouse.name)
//                TextField("Location", text: $warehouse.location)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        Task {
//                           await register()
//                        }
//                    } label: {
//                        Image(systemName: "checkmark")
//                    }
//                }
            
            VStack {
                Form {
                    Section(header: Text("Add WareHouse")) {
                        TextField("Warehouse Name", text: $warehouse.name)
                        TextField("Location", text: $warehouse.location)
                    }
                }
                //Add Button
                Button {
                    Task {
                        await register()
                    }
                } label: {
                    Text("ADD")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.yellow)
                .padding()
            }
        }
    }
    //register warehouse
    private func register() async {
        do {
            try await wareHouseService.registerWareHouse(warehouse:warehouse)
        } catch {
            print(error)
        }
    }
}

struct AddWareHouse_Previews: PreviewProvider {
    static var previews: some View {
        AddWareHouse(warehouse: WareHouse())
    }
}
