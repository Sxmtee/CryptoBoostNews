//
//  AuthScreen.swift
//  CryptoBoost
//
//  Created by mac on 03/01/2025.
//

import SwiftUI

struct AuthScreen: View {
    @State private var navigator = AuthNavigator()
    
    var body: some View {
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

#Preview {
    AuthScreen()
}
