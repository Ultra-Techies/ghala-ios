//
//  phoneInputView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject var userViewModel = UserViewModel(userService: UserService())
    @ObservedObject private var countryInfo = ReadCountryCode()
    @State private var selectedIndex2 =   113 //position of country-Kenya in [countryInfo]
    @State var number = ""
    @FocusState private var dismissKeyboard: Bool
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    // MARK: -Top view
                    TopInfoSubView(title: "Mobile Number", description: "We need to send an OTP to authenticate your number")
                        .frame(height: geo.size.height * 0.55, alignment: .top)
                    
                    // MARK: -Bottom View
                    VStack {
                        HStack {
                            Text("Select Country")
                                .bold()
                                .font(.title3)
                               // .foregroundColor(.black)
                           Spacer()
                            //MARK: -Country Code
                            Picker("Please choose a country Code", selection: $selectedIndex2) {
                                ForEach(0..<countryInfo.codeCountry.count, id: \.self) {
                                    Text("\(countryInfo.codeCountry[$0].name) \(countryInfo.codeCountry[$0].flag) \(countryInfo.codeCountry[$0].dialCode) ")
                                }
                            }
                            .foregroundColor(.black)
                        } .padding(.top, 50)
                            .padding(.horizontal, 20)
                        //MARK: Phone Number
                        TextField("722 222 222", text: $number.max(9))
                            .frame(width: 350.0)
                            .overlay(VStack{Divider().frame(height: 2).background(Color.buttonColor).offset(x: 0, y: 15)})
                            .padding(.top, 10)
                            .keyboardType(.numberPad)
                            .focused($dismissKeyboard)
                        //MARK: Next Button
                        Button(action: {
                            Task {
                                await checkNumberStatus()
                            }
                         }) {
                             Text("NEXT")
                                 .accentColor(.white)
                                 .frame(width: 350, height: 50)
                         }
                         .background(Color.buttonColor).opacity(userViewModel.isLoading ? 0 :  1)
                         .overlay {
                             ProgressView()
                                 .opacity(userViewModel.isLoading ? 1 : 0)
                         }
                         .padding(.top, 50)
                         .disabled(checkTextFieldStatus())
                         .opacity(checkTextFieldStatus() ? 0 : 1)
                    } .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                    // MARK: Curving view
                        .background(
                            RoundedCornersShape(corners: .topLeft, radius: 39)
                                .fill(Color.listBackground)
                        )
                        .offset(y: -43)
                    // MARK: Navigation View
                    NavigationLink(destination: PinVerificationView(user: userViewModel.user), isActive: $userViewModel.toPin ,label: EmptyView.init) // to PIN View
                    NavigationLink(destination: OTPVerificationView(user: userViewModel.user), isActive: $userViewModel.toOTP ,label: EmptyView.init)// to OTP View
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            dismissKeyboard = false
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .alert(userViewModel.errorMsg, isPresented: $userViewModel.showAlert) {}
    }
    // MARK: Check Button Status
    func checkTextFieldStatus() -> Bool {
        if number.isEmpty && number.count < 9 {
            return true
        }
        return false
    }
    // MARK: Check if User Number Exists
    func checkNumberStatus() async {
        let countryCode = countryInfo.codeCountry[selectedIndex2].dialCode
        let phone = countryCode + number
        print(phone)
        await userViewModel.checkIfUserExists(phoneNumber:phone)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
