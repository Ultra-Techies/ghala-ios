//
//  DeliveryViewModel.swift
//  Ghala
//
//  Created by mroot on 26/06/2022.
//

import Foundation

@MainActor
class DeliveryViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var isLoading: Bool = false
    @Published var searchDelivery = ""
    @Published var showToast = false
    @Published var toDispatch: Bool = false
    // From Models
    @Published var delivery = [Delivery]()
    @Published var deliveryUpload = Delivery()
    // From Service
    var deliveryService: DeliveryService
    init(deliveryService: DeliveryService) {
        self.deliveryService = deliveryService
    }
    // MARK: Get Delivery by WH
    func getDeliveriesWH() async {
        do {
            let deliveryData = try await deliveryService.getDeliveriesByWH()
            DispatchQueue.main.async {
                self.delivery = deliveryData
            }
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Search Delivery
    var deliverySearch: [Delivery] {
        if searchDelivery.isEmpty {
            return delivery
        } else {
            return delivery.filter { $0.deliveryWindow.localizedCaseInsensitiveContains(searchDelivery)}
        }
    }
    // MARK: Create Delivery
    func createDeliveryNote(order: Order) async {
        do {
            /*
             "route":"A1",
             "orderIds":[3,4],
             "deliveryWindow":"MORNING",
             "warehouseId":3
             */
            isLoading = true
            print("Order Name \(order.customerName)")
            print("Order Name \(order.id)")
            deliveryUpload.route = order.route
            deliveryUpload.deliveryWindow = order.deliveryWindow
            deliveryUpload.orderIds = [order.id]
            deliveryUpload.warehouseId = FromUserDefault.warehouseID
            print(deliveryUpload.orderIds)
            try await deliveryService.createDeliveryNote(delivery: deliveryUpload)
            DispatchQueue.main.async {
                self.isLoading = false
                self.showToast = true
                self.toDispatch = true
            }
        } catch {
            handleError(error: error.localizedDescription)
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
