//
//  OrderView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var orderService = OrderService()
    @State var selectedItems: [Int] = []
    @State var selectedRow: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                FilterView()
                List {
                    ForEach(orderService.orderDTO, id: \.id) { order in
                        OrderCell(customer: order.customerName, orderCode: order.orderCode, deliveryDate: order.due, price: order.value, items: order.items, status: order.status, isSelected: self.selectedItems.contains(order.id)) {
                            if self.selectedItems.contains(order.id) {
                                self.selectedItems.removeAll(where: {$0 == order.id })
                            } else {
                                self.selectedItems.append(order.id)
                                print(selectedItems)
                            }
                        }
                            .padding()
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }.listRowBackground(Color.clear)
                        .background(Color.listBackground)
                }
                .listStyle(SidebarListStyle())
                let _ = print("Item: \(selectedItems)")
                let array = selectedItems
                if array != [] {
                    Button  {
                        print("To Dispatch")
                    } label: {
                        Text("Dispatch")
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
