//
//  AuthNavigator.swift
//  CryptoBoost
//
//  Created by mac on 03/01/2025.
//

import Foundation
import SwiftUI

@Observable
class AuthNavigator {
    var currentScreen: AuthScreen = .login
    
    enum AuthScreen {
        case login
        case signup
    }
    
    func switchToLogin() {
        currentScreen = .login
    }
    
    func switchToSignup() {
        currentScreen = .signup
    }
}
