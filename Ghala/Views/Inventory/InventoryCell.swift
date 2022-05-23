//
//  InventoryCell.swift
//  Ghala
//
//  Created by mroot on 23/05/2022.
//

import SwiftUI

struct InventoryCell: View {
    @State var name: String
    @State var Category: String
    @State var SKU: String
    @State var price: Int
    @State var quantity: Int
    @State var status: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .bold()
                Spacer()
                Text("\(quantity) items")
            }
            HStack {
                Text("Category: \(Category)")
                Spacer()
                Text(status)
            }
            Text("SKU: \(SKU)")
            Text("Price: \(price)")
        }
    }
}

struct InventoryCell_Previews: PreviewProvider {
    static var previews: some View {
        InventoryCell(name: "Kimbo", Category: "Oil", SKU: "FFNJDF", price: 400, quantity: 25, status: "AVAILABLE")
    }
}
