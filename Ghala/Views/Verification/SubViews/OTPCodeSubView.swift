//
//  OTPCodeView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI

struct OTPCodeSubView: View {
    @ObservedObject var userService = UserService()
    @ObservedObject var user : User
    @State private var otpText: String = ""
    @State private var otpFields: [String] = Array(repeating: "", count: 4)
    @FocusState var activeFiled: OTPField?
    @State var loading: Bool = false
    @State var otpReceived = ""
    @State private var toAccSetup = false
    
    @State var showAlert: Bool = false
    @State var errorMsg: String = ""
    var body: some View {
        VStack {
            OTPField()
            let _ = print(String(describing: "OTP is on OTP Screen:  \(otpReceived)"))
            // MARK: VERIFY Button
            Button {
                verifyOTP()
            } label: {
                Text("Verify")
                    .padding()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.buttonColor).opacity(loading ? 0 :  1)
            .background(
                Rectangle()
                    .fill(Color.buttonColor)
                    .opacity(loading ? 0 : 1)
            )
            .overlay {
                ProgressView()
                    .opacity(loading ? 1 : 0)
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
                    await getOTP()
                }
            } label: {
                Text("Resend OTP CODE")
                    .fontWeight(.medium)
                    .underline()
                    .padding(.top, 10)
                    .foregroundColor(.yellow)
            }
            .fullScreenCover(isPresented: $toAccSetup) {
                AccountSetupView(user: user)
            }
        }.padding()
            .onChange(of: otpFields) { newValue in
                OTPCondition(value: newValue)
            }
            .onAppear {
                Task {
                   await getOTP()
                }
            }
            .alert(errorMsg, isPresented: $showAlert) {}
    }
    // MARK: Check Button Status
    func checkStatus() -> Bool {
        for index in 0..<4 {
            if otpFields[index].isEmpty {
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
                otpFields[index] = String(value[index].last!)
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
                    TextField("", text: $otpFields[index])
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
    // MARK: GET OTP
    func getOTP() async {
        do {
            try await userService.getOTP(user: user)
            otpReceived = userService.otpCode.otp
        } catch {
            handleError(error: error.localizedDescription)
        }
    }
    func verifyOTP() {
        loading = true
        otpText = otpFields.reduce("") { partialResult, value in
            partialResult + value
        }
        print("From Verify: \(otpReceived)")
        if otpText != otpReceived {
            let error = "OTP Did not match"
            handleError(error: error)
        } else {
            loading = false
            toAccSetup.toggle()
            print("Same!!! to create account")
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
