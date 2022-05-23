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
            VStack {
                TextField("Warehouse Name", text: $warehouse.name)
                TextField("Location", text: $warehouse.location)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                           await register()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
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
