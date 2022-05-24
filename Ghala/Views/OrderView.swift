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
                    ForEach(orderService.orderDTO, id: \.id) { order in
                        Text(order.customerName)
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
