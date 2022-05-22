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
//    @State private var wareHouseName = ""
//    @State private var location = ""
    //Backto WH view
    @State private var toWareHouseView = false
    
    
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
                
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        <#code#>
//                    } label: {
//                        Image(systemName: "")
//                    }
//                }
            }
        }
    }
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
