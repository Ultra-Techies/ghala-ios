//
//  GhalaApp.swift
//  Ghala
//
//  Created by mroot on 11/05/2022.
//

import SwiftUI

@main
struct GhalaApp: App {
    var body: some Scene {
        WindowGroup {
          // SplashScreen()
            ContentView(user: User())
        }
    }
}
