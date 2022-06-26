//
//  DispatchView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct DispatchView: View {
    @StateObject var deliveryViewModel = DeliveryViewModel(deliveryService: DeliveryService())
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(deliveryViewModel.deliverySearch) { delivery in
                        DispatchCell(noteCode: delivery.noteCode, orders: delivery.orders, route: delivery.route, status: delivery.status, deliveryWindows: delivery.deliveryWindow)
                            .padding()
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }.listRowBackground(Color.clear)
                        .background(Color.listBackground)
                }
                .listStyle(SidebarListStyle())
                .navigationTitle("Dispatch")
                .searchable(text: $deliveryViewModel.searchDelivery, prompt: "Search Item")
                .refreshable {
                    Task {
                        await deliveryViewModel.getDeliveriesWH()
                    }
                }
                
                
            }
        }.task {
            await deliveryViewModel.getDeliveriesWH()
        }
        .alert(deliveryViewModel.errorMsg, isPresented: $deliveryViewModel.showAlert) {}
    }
}

struct DispatchView_Previews: PreviewProvider {
    static var previews: some View {
        DispatchView()
    }
}
