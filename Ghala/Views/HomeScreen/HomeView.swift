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
    @ObservedObject var userService =  UserService()
    @State var showDrawerMenu = false
    var body: some View {
            let drag = DragGesture()
                .onEnded {
                    if $0.translation.width < -100 {
                        withAnimation {
                            self.showDrawerMenu = false
                        }
                    }
                }
        //MARK: - Drawer
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                       // MainView(user: user, showDrawerMenu: self.$showDrawerMenu)
                        MainView(user: user)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .transition(.move(edge: .leading))
                            .offset(x: self.showDrawerMenu ? geo.size.width * 0 : 0)
                            .disabled(self.showDrawerMenu ? true : false)
                        
                        if self.showDrawerMenu {
                            DrawerView(user: user)
                                .frame(width: geo.size.width/1.2)
                        }
                    }.gesture(drag)
                }
               // Image(systemName: "plus.circle.fill")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user: User())
    }
}
