//
//  DispatchCell.swift
//  Ghala
//
//  Created by mroot on 27/05/2022.
//

import SwiftUI

struct DispatchCell: View {
    @State var noteCode: String
    @State var orders: [OrderElement]
    @State var route: String
    @State var status: DeliveryStatus
    @State var deliveryWindows: String
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(noteCode)
                    .bold()
                Spacer()
                Text("\(orders.count) Orders")
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
                    Text("return")
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

//struct DispatchCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DispatchCell()
//    }
//}
