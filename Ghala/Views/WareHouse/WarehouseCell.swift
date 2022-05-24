//
//  WarehouseCell.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct WarehouseCell: View {
    
    @State var name = ""
    @State var location = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(name)
                .bold()
                .font(.title2)
            Text(location)
                .fontWeight(.light)
        }.padding()
    }
}

struct WarehouseCell_Previews: PreviewProvider {
    static var previews: some View {
        WarehouseCell(name: "Kile", location: "Kileleshwa")
    }
}
