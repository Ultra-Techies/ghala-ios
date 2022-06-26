//
//  OrderView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI
import AlertToast

struct OrderView: View {
    @StateObject var orderViewModel = OrderViewModel(orderService: OrderService())
    @StateObject var deliveryViewModel = DeliveryViewModel(deliveryService: DeliveryService())
    @State private var isEditMode: EditMode = .active
    var body: some View {
        NavigationView {
                VStack {
                    List(selection: $orderViewModel.selection) {
                        ForEach(orderViewModel.orderSearch, id: \.self) { order in
                            OrderCell(customer: order.customerName, orderCode: order.orderCode, deliveryDate: order.due, price: order.value, items: order.items, status: order.status)
                                .padding()
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        }.listRowBackground(Color.clear)
                            .background(Color.listBackground)
                    }
                    .listStyle(SidebarListStyle())
                    .searchable(text: $orderViewModel.searchOrder, prompt: "Search Order")
                    .refreshable {
                        Task {
                            await orderViewModel.getOrders()
                        }
                    }
                    //Check if item on list has been checked
                    if !orderViewModel.selection.isEmpty {
                        //Delivery Button
                        Button {
                            Task {
                                //MARK: To-DO Create Delivery Note
                               //await createDelivery()
                                await editButtonSelected()
                                //deliveryNote()
                            }
                        } label: {
                            Text("DELIVERY NOTE")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .frame(height: 50)
                        .background(Color.yellow)
                        .opacity(deliveryViewModel.isLoading ? 0: 1)
                        .overlay{
                            ProgressView()
                                .opacity(deliveryViewModel.isLoading ? 1 : 0)
                        }
                        .padding(.bottom, 20)
                    }
                    NavigationLink(destination: DispatchView(),isActive: $deliveryViewModel.toDispatch ,label: EmptyView.init)
                }
                .navigationTitle(title())
                .toolbar {
                    EditButton()
                }
        }.task {
            await orderViewModel.getOrders()
        }
        .alert(orderViewModel.errorMsg, isPresented: $orderViewModel.showAlert) {}
        .toast(isPresenting: $deliveryViewModel.showToast, alert: {
            return AlertToast(type: .systemImage("checkmark", Color.yellow), title: "Items have been Dispatch Successfully")
            })
    }
    func editButtonSelected() async {
        for item in orderViewModel.selection {
            await deliveryViewModel.createDeliveryNote(order: item)
        }
    }
    func deliveryNote() {
        let orderCustomer = orderViewModel.selection.hashValue
        print("Hash Value = \(orderCustomer)")
    }
    // Navigation Title when order is Selected.
    func title() -> String {
        if !orderViewModel.selection.isEmpty {
            return "\(orderViewModel.selection.count) Selected"
        } else {
            return "Orders"
        }
    }
}

struct Order_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
