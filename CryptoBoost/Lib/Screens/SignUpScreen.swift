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
            
            Text("Name")
                .font(.system(size: 20, weight: .medium))
                .padding(.bottom, 5)
            
            TextField("", text: $viewModel.name, prompt: Text("enter your name"))
                .keyboardType(.namePhonePad)
                .autocapitalization(.none)
                .textFieldStyle(.plain)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(.blue, lineWidth: 1)
                )
                .padding(.bottom, 15)
            
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
            .padding(.bottom, 50)
            
            CustomButton(
                action: {
                    Task {
                        await viewModel.signUp()
                    }
                },
                width: .infinity,
                text: "Sign Up"
            )
            .padding(.bottom, 20)
            
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

#Preview {
    SignUpScreen()
}
