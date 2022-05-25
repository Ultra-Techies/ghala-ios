//
//  OrderView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var orderService = OrderService()
    var body: some View {
        NavigationView {
            VStack {
                List {
//                    ForEach(orderService.orderDTO, id: \.id) { order in
//                        VStack(alignment: .leading) {
//                            HStack {
//                                    Text(order.customerName)
//                            Spacer()
//                                ForEach(order.items, id: \.sku) { item in
//                                    //Text(item.name)
//                                    Text("\(item.quantity)")
//                                }
//                            }
//                                HStack {
//                                Text("Order ID: \(order.orderCode)")
//                                    Spacer()
//                                    Text(order.status)
//                                }
//                                Text(order.due)
//                        }
//                    }
                    
                    ForEach(orderService.orderDTO, id: \.id) { order in
//                        OrderCell(customer: order.customerName, orderCode: order.orderCode, deliveryDate: order.due, items: order.items, quantity: order.items, status: order.status)
                        OrderCell(customer: order.customerName, orderCode: order.orderCode, deliveryDate: order.due, price: order.value, items: order.items, quantity: order.items, status: order.status)
                    }
                }
            }
        }.task {
           await getOrderId()
        }
    }
    func getOrderId() async {
        do {
            try await orderService.getOrderById()
        } catch {
            print(error)
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
