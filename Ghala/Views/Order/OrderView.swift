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
                            .padding()
                           
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }.listRowBackground(Color.clear)
                    .background(Color.white)
                }
                .listStyle(SidebarListStyle())
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
