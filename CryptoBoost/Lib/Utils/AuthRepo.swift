//
//  AuthRepo.swift
//  CryptoBoost
//
//  Created by mac on 03/01/2025.
//

import Foundation
import Combine

@Observable
class AuthModel {
    var email = "" {
        didSet { validateEmail() }
    }
    var password = "" {
        didSet { validatePassword() }
    }
    var isLoading = false
    var error: String?
    
    // Validation states
    var isEmailValid = false
    var isPasswordValid = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        validateEmail()
        validatePassword()
    }
    
    private func validateEmail() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        isEmailValid = emailPredicate.evaluate(with: email)
    }
    
    private func validatePassword() {
        isPasswordValid = password.count >= 8
    }
    
    func signUp() async {
        guard isEmailValid && isPasswordValid else {
            error = "Please enter valid email and password"
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network call
            // Add your actual authentication API call here
            isLoading = false
        } catch {
            isLoading = false
            self.error = error.localizedDescription
        }
    }
    
    func login() async {
        guard isEmailValid && isPasswordValid else {
            error = "Please enter valid email and password"
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network call
            // Add your actual login API call here
            isLoading = false
        } catch {
            isLoading = false
            self.error = error.localizedDescription
        }
    }
    
    func resetPassword() async {
        guard isEmailValid else {
            error = "Please enter a valid email"
            return
        }
        
        isLoading = true
        error = nil
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network call
            // Add your actual password reset API call here
            isLoading = false
        } catch {
            isLoading = false
            self.error = error.localizedDescription
        }
    }
}
