//
//  H.swift
//  Ghala
//
//  Created by mroot on 01/06/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var user: User
    var body: some View {
        VStack {
        HomeUserCell(user: user)
                .padding(.bottom, 20)
        ChartView()
            Spacer()
        }
    }
}

struct H_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user:User())
    }
}
