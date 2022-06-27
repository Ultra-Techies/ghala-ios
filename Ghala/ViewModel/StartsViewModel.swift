//
//  StartsViewModel.swift
//  Ghala
//
//  Created by mroot on 27/06/2022.
//

import Foundation
@MainActor
class StartsViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var isLoading: Bool = false

    @Published var starts = Starts(inventoryValue: 0, orderValue: [OrderValue]())

    var startsService: StartsService
    init(startsService: StartsService) {
        self.startsService = startsService
    }

    // MARK: Get Starts
    func getStarts() async {
        do {
            let startsData = try await startsService.getStarts()
            print("Starts Data is \(startsData)")
            self.starts = startsData
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    // MARK: Total Sum
    func totalSum() -> Int {
        var sumValue = 0
        for sumOrder in starts.orderValue {
            sumValue = sumOrder.sum
        }
        return sumValue
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
