//
//  AuthRepo.swift
//  CryptoBoost
//
//  Created by mac on 03/01/2025.
//

import Foundation
import Combine
import FirebaseAuth
import Firebase

@Observable
class AuthModel {
    var name = "" {
        didSet { validateName() }
    }
    var email = "" {
        didSet { validateEmail() }
    }
    var password = "" {
        didSet { validatePassword() }
    }
    
    var showErrorSnackbar = false
    var showSuccessSnackbar = false
    
    var isLoading = false
    var error: String? {
        didSet {
            if error != nil {
                showErrorSnackbar = true
            }
        }
    }
    var successMessage: String? {
        didSet {
            if successMessage != nil {
                showSuccessSnackbar = true
                showErrorSnackbar = false
            }
        }
    }
    
    func clearFields() {
        name = ""
        email = ""
        password = ""
    }
    
    // Validation states
    var isNameValid = false
    var isEmailValid = false
    var isPasswordValid = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        validateName()
        validateEmail()
        validatePassword()
    }
    
    private func validateName() {
        isNameValid = name.count >= 3
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
        guard isEmailValid && isPasswordValid && isNameValid else {
            error = "Please enter valid email and password and name"
            return
        }
        
        isLoading = true
        error = nil
        successMessage = nil
        
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            let firestore = Firestore.firestore()
            let userData: [String: Any] = [
                "name": name,
                "email": email,
                "password": password,
                "id": authResult.user.uid
            ]
            
            try await firestore.collection("users").document(authResult.user.uid).setData(userData)
            
            isLoading = false
            successMessage = "Account created successfully!"
            clearFields()
        } catch let error as NSError {
            isLoading = false
            
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                self.error = "Email is already in use"
            case AuthErrorCode.invalidEmail.rawValue:
                self.error = "Invalid email format"
            case AuthErrorCode.weakPassword.rawValue:
                self.error = "Password is too weak"
            default:
                self.error = error.localizedDescription
            }
        }
    }
    
    func login() async {
        guard isEmailValid && isPasswordValid else {
            error = "Please enter valid email and password"
            return
        }
        
        isLoading = true
        error = nil
        successMessage = nil
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)

            isLoading = false
            successMessage = "Logged In successfully!"
            clearFields()
        } catch let error as NSError {
            isLoading = false
            
            switch error.code {
            case AuthErrorCode.wrongPassword.rawValue:
                self.error = "Incorrect password"
            case AuthErrorCode.userNotFound.rawValue:
                self.error = "No account found with this email"
            case AuthErrorCode.userDisabled.rawValue:
                self.error = "This account has been disabled"
            case AuthErrorCode.invalidEmail.rawValue:
                self.error = "Invalid email format"
            default:
                self.error = error.localizedDescription
            }
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
            try await Auth.auth().sendPasswordReset(withEmail: email)

            isLoading = false
        } catch {
            isLoading = false
            self.error = error.localizedDescription
        }
    }
    
    func logout() async {
        isLoading = true
        error = nil
        successMessage = nil
        
        do {
            try Auth.auth().signOut()
            isLoading = false
            successMessage = "Logged out successfully!"
            clearFields()
        } catch {
            isLoading = false
            self.error = "Failed to log out: \(error.localizedDescription)"
        }
    }
}
