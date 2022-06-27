//
//  OrderViewModel.swift
//  Ghala
//
//  Created by mroot on 26/06/2022.
//

import Foundation

@MainActor
class OrderViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var isLoading: Bool = false
    @Published var searchOrder = ""
    @Published var selection = Set<Order>()
    @Published var isSelected: Bool = false
    //Model
    @Published var order = [Order]()
    // Service
    var orderService: OrderService
    init(orderService: OrderService) {
        self.orderService = orderService
    }
    // MARK: Get Orders by Warehouse
    func getOrders() async {
        do {
            let orderData = try await orderService.getOrderById()
            DispatchQueue.main.async {
                self.order = orderData
            }
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Search Order
    var orderSearch: [Order] {
        if searchOrder.isEmpty {
            return order
        } else {
            return order.filter { $0.customerName.localizedCaseInsensitiveContains(searchOrder)}
        }
    }
    // MARK: - Error
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
}
