//
//  OrderCell.swift
//  Ghala
//
//  Created by mroot on 24/05/2022.
//

import SwiftUI

struct OrderCell: View {
    @ObservedObject var orderService = OrderService()
    var order = [Order]()
    @State var customer: String
    @State var orderCode: String
    @State var deliveryDate: String
    @State var price: Int
    @State var items: [Item]
    @State var quantity: [Item]
    @State var status: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(customer)
                    .bold()
                Spacer()
                Text("\(items.count) items")
            }
            HStack{
                Text("Order ID: \(orderCode)")
                Spacer()
                Text(status)
            }
            Text("Delivery date: \(deliveryDate)")
            Text("Price: \(price)")
            //looping through item in array
//            ForEach(items, id: \.sku) { item in
//                Text("\(item.totalPrice)")
//            }
        }
    }
}
