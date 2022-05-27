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
            FilterView()
            VStack {
                //Dispatch ListView
                List {
                    ForEach(deliveryService.deliveryDTO, id: \.id) { delivery in
                        
                    }
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
