//
//  OrderCell.swift
//  Ghala
//
//  Created by mroot on 24/05/2022.
//

import SwiftUI

struct OrderCell: View {
    @State var customer: String
    @State var orderCode: String
    @State var deliveryDate: String
    @State var price: Int
    @State var quantity: Int
    @State var status: String
    var body: some View {
        VStack {
            HStack {
                Text(customer)
                    .bold()
                Spacer()
                Text("\(quantity) items")
            }
            HStack{
                Text("Order ID: \(orderCode)")
                Spacer()
                Text(status)
            }
            Text("Delivery date: \(deliveryDate)")
            Text("Price: \(price)")
        }
    }
}

//struct OrderCell_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderCell(customer: <#T##String#>, orderCode: <#T##String#>, deliveryDate: <#T##String#>, price: <#T##Int#>, quantity: <#T##Int#>, status: <#T##String#>)
//    }
//}
