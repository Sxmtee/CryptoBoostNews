//
//  AuthScreen.swift
//  CryptoBoost
//
//  Created by mac on 03/01/2025.
//

import SwiftUI

struct AuthScreen: View {
    @State private var navigator = AuthNavigator()
    @State private var authModel = AuthModel()
    
    var body: some View {
        if authModel.isUserLoggedIn {
            ContentView()
        } else {
            NavigationStack {
                Group {
                    switch navigator.currentScreen {
                    case .login:
                        LoginScreen()
                    case .signup:
                        SignUpScreen()
                    }
                }
                .environment(navigator)
            }
        }
    }
}

#Preview {
    AuthScreen()
}
