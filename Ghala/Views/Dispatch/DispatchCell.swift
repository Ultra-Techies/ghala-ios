//
//  DispatchCell.swift
//  Ghala
//
//  Created by mroot on 27/05/2022.
//

import SwiftUI

struct DispatchCell: View {
    @State var noteCode: String
    @State var orders: [Order]
    @State var route: String
    @State var status: DeliveryStatus
    @State var deliveryWindows: String
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(noteCode)
                    .bold()
                Spacer()
                Text("\(orders.count) Order")
            }
            HStack {
                Text("Route: \(route)")
                Spacer()
                Text(status.rawValue)
                    .foregroundColor(deliveryStatusColor(status: status))
            }
            Text("Delivery Window: \(deliveryWindows)")
            HStack {
                Spacer()
                Button {
                    print("")
                } label: {
                    Text("Return")
                        .padding(5)
                        .frame(width: 100, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1)
                        )
                        .foregroundColor(.gray)
                }
            }
        }
    }
    //Delivery Status color change
    private func deliveryStatusColor(status: DeliveryStatus) -> Color {
        switch status {
        case .completed:
            return .green
        case .pending:
            return .red
        }
    }
}
