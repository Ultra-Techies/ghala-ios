//
//  SubmittedSucessScreen.swift
//  Ghala
//
//  Created by mroot on 14/05/2022.
//

import SwiftUI

struct SubmittedSucessScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var userService = Service()
    
    @ObservedObject var user : User
    
    var body: some View {
        VStack {
         Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(Color("buttonColor"))
            
            Text("Your registration has been submitted sucessfully")
                .fontWeight(.light)
                .padding(.horizontal, 25.0)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Account holder:")
                        .bold()
                    let joined = user.firstName + " " + user.lastName
                    Text(joined)
                    Spacer()
                    Image(systemName: "pencil")
                } 
                HStack(spacing: 30) {
                   Text("Email:")
                        .bold()
                    Text(user.email)
                    Spacer()
                    Image(systemName: "pencil")
                }
                
                HStack {
                   Text("Assigned Warehouse:")
                        .bold()
                    Text("1")
                    Spacer()
                    Image(systemName: "pencil")
                }
                HStack {
                   Text("Assigned Role:")
                        .bold()
                    Text("Admin")
                    Spacer()
                    Image(systemName: "pencil")
                }
            } .padding(.horizontal, 25.0)
            //.frame(maxWidth: .infinity)
                .padding(.top, 40)
            
            Button {
                Task {
                    print("Verify Details")
                    try await userService.createUser(user: user)
                }
                
                print("confirm")
            } label: {
                Text("CONFIRM")
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
            }
            .background(Color.buttonColor)
            .padding(.top, 50)
        }
    }
}

struct SubmittedSucessScreen_Previews: PreviewProvider {
    static var previews: some View {
        SubmittedSucessScreen(user: User())
    }
}
