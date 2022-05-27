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
    @State var status: String
    @State var deliveryWindows: String
    var body: some View {
        VStack {
            HStack {
                Text(noteCode)
                    .bold()
                Spacer()
                Text("\(orders.count) Orders")
            }
            HStack {
                Text("Route: \(route)")
                Spacer()
                Text(status)
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
}

//struct DispatchCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DispatchCell()
//    }
//}
