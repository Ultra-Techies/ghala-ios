//
//  WareHouseView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct WareHouseView: View {
    
    @ObservedObject var house = WareHouseService()
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(house.warehouse, id: \.id) { ware in
                        WarehouseCell(name: ware.name, location: ware.location)
                            .listRowSeparator(.hidden)
                    }
                }.listStyle(PlainListStyle())
                .navigationTitle("Warehouses")
            }   .frame(maxWidth: .infinity, maxHeight: .infinity)
            
                //search
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                }
        }

        .task {
           await getWareHouses()
        }
    }
    
    func getWareHouses() async {
        do {
            try await house.getAllWareHouse()
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
