//
//  NetworkViewCell.swift
//  Ghala
//
//  Created by mroot on 10/06/2022.
//

import SwiftUI

struct NetworkViewCell: View {
    let netStatus: String
    let image: String
    var body: some View {
        HStack {
           Text(netStatus)
               .padding()
           Image(systemName: image)
           Spacer()
        }
        .frame(height: 30)
       .background(Color.red)
    }
}

struct NetworkViewCell_Previews: PreviewProvider {
    static var previews: some View {
        NetworkViewCell(netStatus: "No internet", image: "")
    }
}
