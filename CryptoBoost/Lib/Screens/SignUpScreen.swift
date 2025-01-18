//
//  SignUpScreen.swift
//  CryptoBoost
//
//  Created by mac on 03/01/2025.
//

import SwiftUI

struct SignUpScreen: View {
    @State private var viewModel = AuthModel()
    @State private var isPasswordVisible = false
    @Environment(AuthNavigator.self) private var navigator
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Sign up to CryptoBoost")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .padding(.bottom, 40)
            
            TextAreas(
                text: $viewModel.name,
                title: "Name",
                hintText: "Enter your full name",
                icon: "person"
            )
            .padding(.bottom, 15)
            
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
            
            CustomButton(
                action: {
                    Task {
                        await viewModel.signUp()
                    }
                },
                width: .infinity,
                text: "Sign Up"
            )
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
            
            HStack {
                Text("Already have an account?")
                    .font(.system(size: 17, weight: .light))
                
                Button {
                    navigator.switchToLogin()
                } label: {
                    Text("Login")
                        .font(.system(size: 17, weight: .medium))
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .frame(maxHeight: .infinity,alignment: .topLeading)
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

extension SignUpScreen: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return viewModel.isEmailValid
        && viewModel.isPasswordValid
        && viewModel.isNameValid
    }
}

#Preview {
    SignUpScreen()
        .environment(AuthNavigator())
}
