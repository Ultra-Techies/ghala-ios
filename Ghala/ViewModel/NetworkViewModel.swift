//
//  NetworkViewModel.swift
//  Ghala
//
//  Created by mroot on 10/06/2022.
//

import Foundation
import Network

class NetworkViewModel: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkViewModel")
    @Published var isNotConnected = true
    
    
    var imageName: String {
        return isNotConnected ? "wifi" : "wifi.slash"
    }
    
    var conncetionDescription: String {
        return "No internet connection"
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isNotConnected = path.status == .unsatisfied
            }
        }
        monitor.start(queue: queue)
    }
    
}
