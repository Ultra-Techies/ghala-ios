//
//  enterOTP.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct enterOTP: View {
    
    @ObservedObject var userViewModel = UserViewModel(userService: Service())
    @ObservedObject var user : User
    
    var body: some View {
        NavigationView {
            switch userViewModel.state {
                
            case .trueN:
                VStack {
                Text("exist1")
            }
            case .falseN:
                VStack {
                Text("False1")
            }
            case .loading:
                ProgressView()
                
            case .failed(error: let error):
                Text(error.localizedDescription)
            case .notAvailable:
                EmptyView()
            }
            
        }
        .task {
           await userViewModel.checkIfUserExists(user: user)
        }

    }
    
}

struct enterOTP_Previews: PreviewProvider {
    static var previews: some View {
        enterOTP(user: User())
    }
}
