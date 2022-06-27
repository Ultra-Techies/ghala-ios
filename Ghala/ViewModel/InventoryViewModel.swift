//
//  InventoryViewModel.swift
//  Ghala
//
//  Created by mroot on 24/06/2022.
//

import Foundation

@MainActor
class InventoryViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var isLoading: Bool = false
    @Published var searchInventory = ""
    // Model
    @Published var inventory = [Inventory]()
    // Serive
    var inventoryService: InventoryService
    init(inventoryService: InventoryService) {
        self.inventoryService = inventoryService
    }
    
    // MARK: Get Inventory
    func getInventory() async {
        do {
            let inventoryData = try await inventoryService.getAllInventory()
            // Control concurrency
            DispatchQueue.main.async {
                self.inventory = inventoryData
            }
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Search
    var inventorySearch: [Inventory] {
        if searchInventory.isEmpty {
            return inventory
        } else {
            return inventory.filter { $0.category.localizedCaseInsensitiveContains(searchInventory)}
        }
    }
    // MARK: Add Inventory
    func addInventory(inventory: Inventory) async {
        do {
            isLoading = true
            let warehouseId = FromUserDefault.warehouseID
            inventory.warehouseId = warehouseId
            print("Inventory WarehouseId: \(inventory.warehouseId)")
            try await inventoryService.addInventory(inventory: inventory)
            DispatchQueue.main.async {
                self.isLoading = false
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
