//
//  AddWareHouse.swift
//  Ghala
//
//  Created by mroot on 21/05/2022.
//

import SwiftUI

struct AddWareHouse: View {
    @State private var wareHouseName = ""
    @State private var location = ""
    //view
    @State private var toWareHouseView = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                TextField("Warehouse Name", text: $wareHouseName)
                TextField("Location", text: $location)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("add warehouse")
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
}

struct AddWareHouse_Previews: PreviewProvider {
    static var previews: some View {
        AddWareHouse()
    }
}
