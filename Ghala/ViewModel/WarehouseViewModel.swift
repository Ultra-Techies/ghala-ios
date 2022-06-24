//
//  WarehouseViewModel.swift
//  Ghala
//
//  Created by mroot on 24/06/2022.
//

import Foundation

@MainActor
class WarehouseViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var isLoading: Bool = false
    @Published var searchWareHouse = ""
    @Published var showToast = false
    // Navigation
    @Published var toAddWareHouse: Bool = false
    
    @Published var wareHouse = [WareHouse]()
    
    var wareHouseService: WareHouseService
    init(wareHouseService: WareHouseService) {
        self.wareHouseService = wareHouseService
    }
    
    //  MARK: -Get All WareHouse
    func getAll() async {
        do {
            let wareHouseData = try await wareHouseService.getAllWareHouse()
            DispatchQueue.main.async {
                self.wareHouse = wareHouseData
            }

        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Search Warehouse
    var wareHouseSearch: [WareHouse] {
        if searchWareHouse.isEmpty {
            return wareHouse
        } else {
            return wareHouse.filter { $0.name.localizedCaseInsensitiveContains(searchWareHouse)}
        }
    }
    // MARK: Add Warehouse
    func addWareHouse(warehouse: WareHouse) async {
        do {
            isLoading = true
            print("Warehouse Name: \(warehouse.name)")
            try await wareHouseService.addWareHouse(warehouse: warehouse)
            DispatchQueue.main.async {
                self.isLoading = false
                self.showToast = true
            }
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: -Error
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
}
