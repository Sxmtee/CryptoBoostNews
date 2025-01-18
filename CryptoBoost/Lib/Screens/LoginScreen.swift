//
//  LoginScreen.swift
//  CryptoBoost
//
//  Created by mac on 18/12/2024.
//

import SwiftUI

struct LoginScreen: View {
    @State private var viewModel = AuthModel()
    @State private var isPasswordVisible = false
    @Environment(AuthNavigator.self) private var navigator
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Login to your Account")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .padding(.bottom, 40)
            
            TextAreas(
                text: $viewModel.email,
                title: "Email",
                hintText: "Enter your email address",
                icon: "mail"
            )
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .padding(.bottom, 15)
            
            TextAreas(
                text: $viewModel.password,
                title: "Password",
                hintText: "Enter your password",
                icon: "lock.fill",
                isSecureField: true
            )
            .padding(.bottom, 30)
            
            Button {
                // code to come
            } label: {
                Text("Forgot password ?")
                    .foregroundStyle(.blue)
                    .font(.system(size: 20, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, 15)
            }
            
            CustomButton(
                action: {
                    Task {
                        await viewModel.login()
                    }
                },
                width: .infinity,
                text: "Login"
            )
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
            
            HStack {
                Text("Do not have an account?")
                    .font(.system(size: 17, weight: .light))
                
                Button {
                    navigator.switchToSignup()
                } label: {
                    Text("Sign up")
                        .font(.system(size: 17, weight: .medium))
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .snackbar(
            isShowing: $viewModel.showErrorSnackbar,
            message: viewModel.error ?? ""
        )
        .snackbar(
            isShowing: $viewModel.showSuccessSnackbar,
            message: viewModel.successMessage ?? "",
            isSuccess: true
        )
    }
}

extension LoginScreen: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return viewModel.isEmailValid && viewModel.isPasswordValid
    }
}

#Preview {
    LoginScreen()
        .environment(AuthNavigator())
}
