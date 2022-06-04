//
//  H.swift
//  Ghala
//
//  Created by mroot on 01/06/2022.
//

import SwiftUI

struct H: View {
    @ObservedObject var user: User
    var body: some View {
        VStack {
        MainView(user: user)
        ChartView()
        }
    }
}

struct H_Previews: PreviewProvider {
    static var previews: some View {
        H(user:User())
    }
}
