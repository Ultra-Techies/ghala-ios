//
//  WareHouseView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct WareHouseView: View {
    @ObservedObject var wareHouseService = WareHouseService()
    @State var toAddWareHouse = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(wareHouseService.warehouse, id: \.id) { ware in
                        WarehouseCell(name: ware.name, location: ware.location)
                            .listRowSeparator(.hidden)
                    }
                }.listStyle(PlainListStyle())
                .navigationTitle("Warehouses")
            }   .frame(maxWidth: .infinity, maxHeight: .infinity)
            
                //search
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            toAddWareHouse.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
        .task {
           await getWareHouses()
        }
        
        .fullScreenCover(isPresented: $toAddWareHouse) {
            AddWareHouse(warehouse: WareHouse())
        }
    }
    
    func getWareHouses() async {
        do {
            try await wareHouseService.getAllWareHouse()
        } catch {
            print(error)
        }
    }
}

struct WareHouseView_Previews: PreviewProvider {
    static var previews: some View {
        WareHouseView()
    }
}
//
//NavigationLink("Press Me", destination: Text("Detail").navigationTitle("Detail View"))
//    .navigationBarTitleDisplayMode(.inline)
//    // this sets the Back button text when a new screen is pushed
//    .navigationTitle("Back to Primary View")
//    .toolbar {
//        ToolbarItem(placement: .principal) {
//            // this sets the screen title in the navigation bar, when the screen is visible
//            Text("Primary View")
//        }
//    }
//}
