//
//  OrderView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var orderService = OrderService()
    @ObservedObject var orderDelivery: OrderElementForDelivery
    @State var selectedItems: [Int] = []
    var body: some View {
        NavigationView {
            VStack {
                FilterView()
                List {
                    //MARK: with ID
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
                }.refreshable(action: {
                    Task {
                        await getOrderId()
                    }
                })
                .listStyle(SidebarListStyle())
                //Check if item on list has been checked
                if selectedItems != [] {
                    //Delivery Button
                    Button {
                        Task {
                            //MARK: To-DO Create Delivery Note
                           await createDelivery()
                        }
                    } label: {
                        Text("DELIVERY NOTE")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(height: 50)
                    .background(Color.yellow)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Orders")
        }.task {
           await getOrderId()
        }
    }
    //get Orders from Warehouse
   private func getOrderId() async {
        do {
            try await orderService.getOrderById()
        } catch {
            print(error)
        }
    }
    //create Delivery Note
    private func createDelivery() async {
        do {
            let selectedIds = selectedItems
            orderDelivery.orderIds = selectedIds
            try await orderService.createDeliveryNote(order: orderDelivery)
        } catch {
            print(error)
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(orderDelivery: OrderElementForDelivery())
    }
}
