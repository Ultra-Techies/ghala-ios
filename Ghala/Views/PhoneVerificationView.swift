//
//  PhoneVerificationView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PhoneVerificationView: View {
    
    var colors = flag
        @State private var selectContryCode =  "KE 🇰🇪"
    
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
                      maxHeight: 350,
                      alignment: .topLeading
                    )
                .background(Color.yellow)
               
                VStack {
                    
                    //MARK: To-Do Add Country Code with flags
                    /*
                     https://www.reddit.com/r/swift/comments/hnjwrm/how_can_i_get_the_country_code_or_country_name/fxds870/
                     
                     
                     */
                    
                    Picker("Please choose a country Code", selection: $selectContryCode) {
                        ForEach(colors, id: \.self) {
                            Text($0)
                        }
                    }.foregroundColor(.black)
                        .padding(.top, 100)
                    
                    TextField("Phone number", text: $user.phoneNumber)
                        .frame(width: 350.0)
                        .overlay(VStack{Divider().offset(x: 0, y: 10)})
                        .padding(.top, 10)
                        .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
                    
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
                .offset(y: -50)
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
