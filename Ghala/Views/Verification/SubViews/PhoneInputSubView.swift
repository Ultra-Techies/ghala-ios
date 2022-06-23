//
//  phoneInputView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct PhoneInputSubView: View {
    @FocusState private var dismissKeyboard: Bool
    @State var loading: Bool = false
    @ObservedObject var user : User
    @ObservedObject var userViewModel = UserViewModel(userService: UserService())
    @ObservedObject private var countryInfo = ReadCountryCode()
    @State private var selectedIndex2 =   113 //position of country-Kenya in [countryInfo]
    @State private var number = "" //phone number
    @State private var toOTPView = false
    @State private var toPinView = false
    
    @State var showAlert: Bool = false
    @State var errorMsg: String = ""
    
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
                                .foregroundColor(.black)
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
                        let locationCode = countryInfo.codeCountry[selectedIndex2].dialCode //get country Code
                        //MARK: Phone Number
                        TextField("722 222 222", text: $number.max(9))
                            .frame(width: 350.0)
                            .overlay(VStack{Divider().frame(height: 2).background(Color.buttonColor).offset(x: 0, y: 15)})
                            .padding(.top, 10)
                            .keyboardType(.numberPad)
                            .focused($dismissKeyboard)
                            .foregroundColor(.black)
                        //MARK: Next Button
                        Button(action: {
                            Task {
                                await checkNumberStatus(locationCode: locationCode, pNumber: number)
                            }
                         }) {
                             Text("NEXT")
                                 .accentColor(.white)
                                 .frame(width: 350, height: 50)
                         }
                         .background(Color.buttonColor).opacity(loading ? 0 :  1)
                         .overlay {
                             ProgressView()
                                 .opacity(loading ? 1 : 0)
                         }
                         .padding(.top, 50)
                         .disabled(checkStatus())
                         .opacity(checkStatus() ? 0 : 1)
                    } .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                    // MARK: Curving view
                        .background(
                            RoundedCornersShape(corners: .topLeft, radius: 50)
                                .fill(Color(UIColor.white))
                        )
                        .offset(y: -43)
                    // MARK: To OTP View
                    NavigationLink(destination: OTPVerificationView(user: user), isActive: $toOTPView, label: EmptyView.init)
                }
                // MARK: To Pin View
                NavigationLink(destination: PinVerificationView(user: user), isActive: $toPinView ,label: EmptyView.init)
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
            .frame(minWidth: 0, maxWidth: .infinity)
            .alert(errorMsg, isPresented: $showAlert) {}
    }
    // MARK: Check Button Status
    func checkStatus() -> Bool {
        if number.isEmpty && number.count < 9 {
            return true
        }
        return false
    }
    //MARK: -To OTP and Pin View
    //checkUser
    func checkNumberStatus(locationCode: String, pNumber: String) async {
        do {
            loading = true
            let userNumber = locationCode + pNumber
            print(userNumber)
            user.phoneNumber = userNumber
            let value = try await userViewModel.checkIfUserExists(user: user)
            loading = false
            if value == false {
                print("To OPT Screen")
                toOTPView = true
            } else {
                print("To Pin Screen")
                toPinView = true
            }
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.loading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
}

struct phoneInputView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneInputSubView(user: User())
    }
}
