//
//  FilterView.swift
//  Ghala
//
//  Created by mroot on 25/05/2022.
//

import SwiftUI

struct FilterView: View {
    var body: some View {
        HStack {
            Image("filter")
            Text("Filter")
            Spacer()
            Text("Category:")
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: 11, height: 11)
        }.padding(.horizontal, 10)
            .padding(.top, 10)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
