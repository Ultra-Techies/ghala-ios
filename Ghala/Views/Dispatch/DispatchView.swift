//
//  DispatchView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct DispatchView: View {
    @ObservedObject var deliveryService = DeliveryService()
    var body: some View {
        NavigationView {
            VStack {
                FilterView()
                //Dispatch ListView
                List {
                    ForEach(deliveryService.deliveryDTO, id: \.id) { delivery in
                        DispatchCell(noteCode: delivery.noteCode, orders: delivery.orders, route: delivery.route ?? "", status: delivery.status, deliveryWindows: delivery.deliveryWindow ?? "")
                            .padding()
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }.listRowBackground(Color.clear)
                        .background(Color.listBackground)
                }.listStyle(SidebarListStyle())
                .refreshable {
                    Task {
                        await getDispatchByWH()
                    }
                }
            }
            .navigationTitle("Dispatch")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "magnifyingglass")
                }
            }
        } .task {
            await getDispatchByWH()
        }
    }
    //get Dispatch By WH
    private func getDispatchByWH() async {
        do {
            try await deliveryService.getDeliveryByWH()
        } catch {
            print(error)
        }
    }
}

struct DispatchView_Previews: PreviewProvider {
    static var previews: some View {
        DispatchView()
    }
}
