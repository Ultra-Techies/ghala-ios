//
//  OTPCodeView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct OTPCodeSubView: View {
    @ObservedObject var user: User
    @StateObject var  userViewModel = UserViewModel(userService: UserService())
    @FocusState var activeFiled: OTPField?
    var body: some View {
        VStack {
            //let _ = print("OTP on Screen : \(userViewModel.otpCode)")
            let otpValue = userViewModel.otpCode
            OTPField()
                .padding(.bottom, 30)
            // MARK: VERIFY Button
            Button {
                Task {
                    await userViewModel.verifyOTP(otpValue: otpValue)
                }
            } label: {
                Text("Verify")
                    .padding()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.buttonColor).opacity(userViewModel.isLoading ? 0 :  1)
            .overlay {
                ProgressView()
                    .opacity(userViewModel.isLoading ? 1 : 0)
            }
            .disabled(checkStatus())
            .opacity(checkStatus() ? 0 : 1)
            
            Text("Did not receive OTP?")
                .fontWeight(.light)
                .foregroundColor(.gray)
                .padding(.top, 20)
            
            // MARK: RESEND OTP
            Button {
                Task {
                    await userViewModel.getOTP(user: user)
                }
            } label: {
                Text("Resend OTP CODE")
                    .fontWeight(.medium)
                    .underline()
                    .padding(.top, 10)
                    .foregroundColor(.yellow)
            }
            .fullScreenCover(isPresented: $userViewModel.toAccountSetUp) {
                AccountSetupView(user: user)
            }
        }.onAppear {
            Task {
                await userViewModel.getOTP(user:user)
            }
        }
        .padding()
        .onChange(of: userViewModel.pinTextFields) { newValue in
            OTPCondition(value: newValue)
        }
        .alert(userViewModel.errorMsg, isPresented: $userViewModel.showAlert) {}
    }
    // MARK: Check Button Status
    func checkStatus() -> Bool {
        for index in 0..<4 {
            if userViewModel.pinTextFields[index].isEmpty {
                return true
            }
        }
        return false
    }
    // MARK: OTP Condition
    func OTPCondition(value: [String]) {
        //limit TextField
        for index in 0..<4 {
            if value[index].count > 1 {
                userViewModel.pinTextFields[index] = String(value[index].last!)
            }
        }
        //move to Previous TextField
        for index in 1...3 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeFiled = activeStateForIndex(index: index - 1)
            }
        }
        //move to the next TextField
        for index in 0..<3 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeFiled {
                activeFiled = activeStateForIndex(index: index + 1)
            }
        }
    }
    // MARK: OTP Text Field
    @ViewBuilder
    func OTPField() -> some View {
        HStack(spacing: 14) {
            ForEach(0..<4, id: \.self) { index in
                VStack {
                    TextField("", text: $userViewModel.pinTextFields[index])
                        .vCodeStyle()
                        .textContentType(.oneTimeCode)
                        .focused($activeFiled, equals: activeStateForIndex(index: index))
                }
                .frame(width: 50, height: 50)
            }
        }
    }
    func activeStateForIndex(index: Int) -> OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        default: return .field4
        }
    }
}
struct OTPCodeView_Previews: PreviewProvider {
    static var previews: some View {
        OTPCodeSubView(user: User())
    }
}
enum OTPField {
    case field1
    case field2
    case field3
    case field4
}
