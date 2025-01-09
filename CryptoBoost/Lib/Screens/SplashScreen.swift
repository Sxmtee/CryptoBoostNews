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
    @State private var isUserLoggedIn = false
    @State private var authListener: AuthStateDidChangeListenerHandle?
    
    
    private func checkAuthState() {
        authListener = Auth.auth().addStateDidChangeListener { auth, user in
            isUserLoggedIn = user != nil
        }
    }
    
    var body: some View {
        if isActive {
            if isUserLoggedIn {
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
                checkAuthState()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            .onDisappear {
                if let listener = authListener {
                    Auth.auth().removeStateDidChangeListener(listener)
                }
            }

        }
    }
}

#Preview {
    SplashScreen()
}
