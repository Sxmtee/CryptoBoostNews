//
//  SplashScreen.swift
//  CryptoBoost
//
//  Created by mac on 18/12/2024.
//

import SwiftUI
import FirebaseAuth

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.5
    @State private var opacity = 0.5
    @State private var authModel = AuthModel()
    
    var body: some View {
        if isActive {
            if authModel.isUserLoggedIn {
                ContentView()
            } else {
                AuthScreen()
            }
        } else {
            VStack {
                VStack {
                    Image(systemName: "newspaper.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.blue)
                    Text("CryptoBoost")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        self.size = 1.0
                        self.opacity = 1.5
                    }
                }
            }
            .onAppear {
                authModel.checkAuthState()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            .onDisappear {
                if let listener = authModel.authListener {
                    Auth.auth().removeStateDidChangeListener(listener)
                }
            }

        }
    }
}

#Preview {
    SplashScreen()
}
