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
    @State var items: [Item]
    @State var status: OrderStatus
    var isSelected: Bool //check if item on list is selected
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            HStack {
                if isSelected {
                Image(systemName: "checkmark")
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text(customer)
                            .bold()
                        Spacer()
                        Text("\(items.count) items")
                    }
                    HStack {
                        Text("Order ID: \(orderCode)")
                        Spacer()
                        Text(status.rawValue)
                            .foregroundColor(orderStatusColor(status: status))
                    }
                    Text("Delivery date: \(deliveryDate)")
                    Text("Price: \(price)")
                }
            }
        }
    }
    private func orderStatusColor(status: OrderStatus) -> Color {
        switch status {
        case .submitted:
            return .gray
        case .pending:
            return .red
        case .delivered:
            return .green
        }
    }
}
//looping through item in array
//            ForEach(items, id: \.sku) { item in
//                Text("\(item.totalPrice)")
//            }
