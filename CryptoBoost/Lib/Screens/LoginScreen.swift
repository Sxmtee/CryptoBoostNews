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
            
            Text("Email")
                .font(.system(size: 20, weight: .medium))
                .padding(.bottom, 5)
            
            TextField("", text: $viewModel.email, prompt: Text("enter your email"))
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(.plain)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(.blue, lineWidth: 1)
                )
                .padding(.bottom, 15)
            
            Text("Password")
                .font(.system(size: 20, weight: .medium))
                .padding(.bottom, 5)
            
            ZStack {
                if isPasswordVisible {
                    TextField(
                        "",
                        text: $viewModel.password,
                        prompt: Text("enter your password")
                    )
                    .textFieldStyle(.plain)
                    .padding(15)
                } else {
                    SecureField(
                        "",
                        text: $viewModel.password,
                        prompt: Text("enter your password")
                    )
                    .textFieldStyle(.plain)
                    .padding(15)
                }
                
                HStack {
                    Spacer()
                    Button{
                        isPasswordVisible.toggle()
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 15)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(.blue, lineWidth: 1)
            )
            .padding(.bottom, 15)
            
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
            .padding(.bottom, 20)
            
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

#Preview {
    LoginScreen()
}
