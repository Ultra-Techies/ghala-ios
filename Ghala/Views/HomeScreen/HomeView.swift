//
//  HomeView.swift
//  Ghala
//
//  Created by mroot on 15/05/2022.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Image(systemName: "rectangle.grid.1x2")
                    .resizable()
                    .frame(width: 25, height: 25)
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.padding(.horizontal, 20)
            
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Hello,")
                    
                        .fontWeight(.light)
                    let joinedName = user.firstName + " " + user.lastName
                    
                    Text(joinedName)
                        .bold()
                }
            } .padding(.horizontal, 20)
            
            Spacer()
            
           // Image(systemName: "plus.circle.fill")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user: User())
    }
}
