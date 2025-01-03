//
//  CryptoBoostApp.swift
//  CryptoBoost
//
//  Created by mac on 16/12/2024.
//

import Firebase
import SwiftUI

@main
struct CryptoBoostApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}
