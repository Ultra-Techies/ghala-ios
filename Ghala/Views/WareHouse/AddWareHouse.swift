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
                        await register()
                    }
                } label: {
                    Text("ADD")
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                }
                .background(Color.yellow)
                .padding()
                .navigationTitle("Add WareHouse")
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
