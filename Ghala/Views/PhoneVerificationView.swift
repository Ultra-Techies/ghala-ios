//
//  PhoneVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PhoneVerificationView: View {
    
    @ObservedObject var userService = Service()
    @ObservedObject var userViewModel = UserViewModel(userService: Service())
    
    @ObservedObject var user : User
    @State private var showOtp = false
    @State private var shownum = false
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    GeometryReader { geo in
                        VStack {
                            Image("logo")
                                .resizable()
                                .frame(width: 130, height: 120)
                            
                            Text("Mobile Number")
                                .font(.title)
                                .bold()
                                .padding(.top, 30)
                                .padding(.bottom, 5)
                            
                            Text("We need to send an OTP to authenticate your number")
                                .fontWeight(.light)
                                //.padding(.horizontal, 10.0)
                                .font(.system(size: 12))
                        }
                        .frame(width: geo.size.width * 1.0)
                    }
                        //.padding()
                }
                .frame(
                      //minWidth: 0,
                      maxWidth: .infinity,
                      maxHeight: 300,
                      alignment: .topLeading
                    )
                .background(Color.yellow)
               
                VStack {
                    
                    TextField("Phone number", text: $user.phoneNumber)
                        .frame(width: 350.0)
                        .overlay(VStack{Divider().offset(x: 0, y: 10)})
                        .padding(.top, 80)
                    
                    Button {
                        Task {
            //                //enterOTP()
            //                await userViewModel.checkIfUserExists(user: user)
            //                showOtp.toggle()
            //                //let value = try await userViewModel.checkU(user: user)
            //                //let _ = print(String(describing: value))
                            await switchView()
                        }
                    } label: {
                        Text("NEXT")
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                    }
                    .background(Color.black)
                    .padding(.top, 50)
                }
                .frame(
                      minWidth: 0,
                      maxWidth: .infinity
                    )
                .background(
                
                    RoundedCornersShape(corners: .topLeft, radius: 50)
                        .fill(Color(UIColor.white))
                    
                )
                .offset(y: -40)
                Spacer()
                            // .padding(.bottom, -130)
            }
        }
        .sheet(isPresented: $showOtp) {
            enterOTP(user: User())
        }
        .sheet(isPresented: $shownum) {
            numberOtp(user: user)
        }
    }
    
    func switchView() async {
        
        do {
            let value = try await userViewModel.checkU(user: user)
            if value == false {
                print("False to OPT")
                shownum.toggle()
            } else {
                showOtp.toggle()
                print("To Pin")
            }
        } catch {
            print(error)
        }
    }
}

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationView(user: User())
    }
}
