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
                FilterView()
                List {                    
                    ForEach(orderService.orderDTO, id: \.id) { order in
                        OrderCell(customer: order.customerName, orderCode: order.orderCode, deliveryDate: order.due, price: order.value, items: order.items, status: order.status)
                    }
                }
            }
            .navigationTitle("Orders")
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
