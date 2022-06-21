//
//  PinVerificationSubView.swift
//  Ghala
//
//  Created by mroot on 12/05/2022.
//

import SwiftUI
struct PinVerificationSubView: View {
    @ObservedObject var userService =  UserService()
    @ObservedObject var user: User
    @State private var pinText: String = ""
    @State private var pinFields: [String] = Array(repeating: "", count: 4)
    @FocusState var activeFiled: OTPField?
    @State var loading: Bool = false
    @State var showAlert: Bool = false
    @State var errorMsg: String = ""
    @State private var toHomeView = false
    var body: some View {
        VStack {
            OTPField()
                .padding(.bottom, 30)
            // MARK: VERIFY Button
            Button {
                Task {
                    await checkPassword()
                }
            } label: {
                Text("Verify")
                    .padding()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.buttonColor).opacity(loading ? 0 :  1)
            .overlay {
                ProgressView()
                    .opacity(loading ? 1 : 0)
            }
            .disabled(checkStatus())
            .opacity(checkStatus() ? 0 : 1)
            .fullScreenCover(isPresented: $toHomeView) {
                ContentView(user: user)
            }
        }
        .padding()
        .onChange(of: pinFields) { newValue in
            OTPCondition(value: newValue)
        }
        .alert(errorMsg, isPresented: $showAlert) {}
    }
    
    // MARK: Check Button Status
    func checkStatus() -> Bool {
        for index in 0..<4 {
            if pinFields[index].isEmpty {
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
                pinFields[index] = String(value[index].last!)
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
                    TextField("", text: $pinFields[index])
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
    func checkPassword() async {
        do {
            loading = true
            pinText = pinFields.reduce("") { partialResult, value in
                partialResult + value
            }
            print(pinText)
            user.password = pinText
            let response = try await userService.verifyUserLogin(user: user)
            print("Status: \(response)")
            
            if response != 200 {
                loading = false
                let wrongPass = "Wrong Pin"
                handleError(error: wrongPass)
                print("Forbiden")
            } else {
                loading = false
                try await userService.findByPhone(user: user)
                toHomeView.toggle()
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

struct PinVerificationSubView_Previews: PreviewProvider {
    static var previews: some View {
       PinVerificationSubView(user: User())
    }
}
