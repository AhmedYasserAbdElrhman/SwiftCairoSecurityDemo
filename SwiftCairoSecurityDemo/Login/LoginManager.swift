//
//  LoginManager.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import Foundation
class LoginManager: ObservableObject {
    @Published var isLoggedIn: Bool
    @Published var username: String
    @Published var password: String
    @Published var isBiometricEnabled: Bool
    @Published var isSecuredBiometricEnabled: Bool

    private let usernameKey = "username"
    private let passwordKey = "password"
    private let isLoggedInKey = "isLoggedIn"
    private let isBiometricEnabledKey = "isBiometricEnabled"
    private let isSecuredBiometricEnabledKey = "isSecuredBiometricEnabled"

    init() {
        self.username = UserDefaults.standard.string(forKey: usernameKey) ?? ""
        self.password = UserDefaults.standard.string(forKey: passwordKey) ?? ""
        self.isLoggedIn = UserDefaults.standard.bool(forKey: isLoggedInKey)
        self.isBiometricEnabled = true
        self.isSecuredBiometricEnabled = false
    }

    func login(username: String, password: String) {
        if isBiometricEnabled {
        }
        if isSecuredBiometricEnabled {
        }
        saveToggles()
    }

    func logout() {
        self.isLoggedIn = false
        UserDefaults.standard.set(false, forKey: isLoggedInKey)
    }

    func saveBiometricEnabled(_ enabled: Bool) {
        self.isBiometricEnabled = enabled
        UserDefaults.standard.set(enabled, forKey: isBiometricEnabledKey)
    }
    
    func updateToggleA(_ value: Bool) {
        print("Value updated toggleA \(value)")
        isBiometricEnabled = value
        isSecuredBiometricEnabled = !value
    }
    
    func updateToggleB(_ value: Bool) {
        print("Value updated toggleB \(value)")
        isSecuredBiometricEnabled = value
        isBiometricEnabled = !value
    }
    
    private func saveToggles() {
        UserDefaults.standard.set(isBiometricEnabled, forKey: isBiometricEnabledKey)
        UserDefaults.standard.set(isSecuredBiometricEnabled, forKey: isSecuredBiometricEnabledKey)
    }
}
