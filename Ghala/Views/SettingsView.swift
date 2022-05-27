//
//  SettingsView.swift
//  Ghala
//
//  Created by mroot on 19/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var userService = UserService()
    var body: some View {
        VStack {
            
        }.task {
           await getUser()
        }
    }
    func getUser() async {
        do {
            try await userService.getUser()
        }catch {
            print(error)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
