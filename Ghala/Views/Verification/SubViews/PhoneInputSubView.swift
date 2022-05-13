//
//  phoneInputView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PhoneInputSubView: View {
    
    var code = flag
    @State private var selectContryCode =  "KE 🇰🇪"
    
    @State private var showOtp = false
    @State private var shownum = false
    
    @ObservedObject var user : User
    @ObservedObject var userViewModel = UserViewModel(userService: Service())
    
    var body: some View {
       
        VStack {
            
            //MARK: -Country Code
            Picker("Please choose a country Code", selection: $selectContryCode) {
                ForEach(code, id: \.self) {
                    Text($0)
                }
            }.foregroundColor(.black)
                .padding(.top, 100)
            
            //MARK: -Phone Number
            TextField("Phone number", text: $user.phoneNumber)
                .frame(width: 350.0)
                .overlay(VStack{Divider().frame(height: 2).background(Color.buttonColor).offset(x: 0, y: 15)})
                .padding(.top, 10)
                .keyboardType(/*@START_MENU_TOKEN@*/.numbersAndPunctuation/*@END_MENU_TOKEN@*/)
            
            //MARK: -Next Button
            Button {
                Task {
                    await switchView()
                }
            } label: {
                Text("NEXT")
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
            }
            .background(Color.buttonColor)
            .padding(.top, 50)
        } .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
        
        .sheet(isPresented: $showOtp) {
            OTPVerificationView(user: user)
        }
        .sheet(isPresented: $shownum) {
            numberOtp(user: user)
        }
    }
    
    //MARK: -To OTP and Pin View
    func switchView() async {
        
        do {
            let value = try await userViewModel.checkU(user: user)
            if value == false {
                print("False to OPT")
                //try? await userViewModel.getCode(user: user)
                showOtp.toggle()
                //shownum.toggle()
            } else {
                shownum.toggle()
                print("To Pin")
            }
        } catch {
            print(error)
        }
    }
    
}

struct phoneInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneInputSubView(user: User())
    }
}
