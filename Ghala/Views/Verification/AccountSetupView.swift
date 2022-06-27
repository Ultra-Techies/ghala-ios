//
//  AccountSetupView.swift
//  Ghala
//
//  Created by mroot on 14/05/2022.
//

import SwiftUI

struct AccountSetupView: View {
    @StateObject var userViewModel = UserViewModel(userService: UserService())
    @ObservedObject var user: User
    @State var toSuccessView = false
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                        VStack {
                            Text("Welcome to Ghala. Please setup your account to start using the app")
                                .padding(.horizontal, 25.0)
                                .multilineTextAlignment(.center)
                                .padding(.top, 50)
                            VStack(spacing: 40) {
                                let _ = print(String(describing: user.phoneNumber))
                                TextField("First Name", text: $user.firstName)
                                    .textFieldStyling()
                                TextField("Last Name", text: $user.lastName)
                                    .textFieldStyling()
                                TextField("Email Address", text: $user.email )
                                    .textFieldStyling()
                                    
                                SecureField("Account Pin",text: $user.password)
                                    .textFieldStyling()
                                    .keyboardType(.numberPad)
                            }
                            .padding(.horizontal, 25.0)
                            .padding(.top, 50)
                            .padding(.bottom, 100)
                            Button {
                                toSuccessView = true
                            } label: {
                                Text("VERIFY")
                                    .foregroundColor(.white)
                                    .frame(width: 350, height: 50)
                            }
                            .disabled(user.firstName.isEmpty || user.lastName.isEmpty || user.email.isEmpty || user.password.isEmpty)
                            .background(Color.buttonColor).opacity(userViewModel.isLoading ? 0 :  1)
                            .overlay {
                                ProgressView()
                                    .opacity(userViewModel.isLoading ? 1 : 0)
                            }
                            Spacer()
                            NavigationLink(destination: SubmittedSucessScreen(user: user), isActive: $toSuccessView ,label: EmptyView.init)
                        }
                    }
            }
            .navigationBarTitle("Setup Your Account", displayMode: .inline)
            .navigationBarColor(backgroundColor: .systemYellow, titleColor: .black)
        }
        .frame(maxHeight: .infinity)
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView(user: User())
    }
}

// MARK: - Text Field Styling
struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(maxWidth: .infinity)
        .overlay(VStack{Divider().frame(height: 2).background(Color.buttonColor).offset(x: 0, y: 15)})
    }
}

extension View {
    func textFieldStyling() -> some View {
        modifier(TextFieldStyle())
    }
}

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
