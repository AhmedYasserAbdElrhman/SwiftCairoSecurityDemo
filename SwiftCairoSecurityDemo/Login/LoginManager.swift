//
//  LoginManager.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import SwiftUI
import LocalAuthentication
class LoginManager: ObservableObject {
    @Published var isLoggedIn: Bool
    @Published var username: String
    @Published var password: String
    @Published var isBiometricEnabled: Bool
    @Published var isSecuredBiometricEnabled: Bool
    @Published var showBiometricsLoginView: Bool
    @Published var biometricType: LABiometryType = .none
    @Published var usernameError: String?
    @Published var passwordError: String?
    @Published var authenticationError: String?
    private let showBiometricsLoginViewKey = "showBiometricsLoginView"
    private let isBiometricEnabledKey = "isBiometricEnabled"
    private let isSecuredBiometricEnabledKey = "isSecuredBiometricEnabled"
    private let server = "www.namespaceserver.com"
    init() {
        self.username = ""
        self.password = ""
        self.isLoggedIn = false
        self.isBiometricEnabled = UserDefaults.standard.bool(forKey: isBiometricEnabledKey)
        self.isSecuredBiometricEnabled = UserDefaults.standard.bool(forKey: isSecuredBiometricEnabledKey)
        self.showBiometricsLoginView = UserDefaults.standard.bool(forKey: showBiometricsLoginViewKey)
        if !isBiometricEnabled && !isSecuredBiometricEnabled {
            isBiometricEnabled = true
            saveToggles()
        }
    }

    func creatAccount() {
        guard validate() else { return }

        let credentials = Credentials(username: username, password: password)
        // Best practice: Consider encrypting sensitive data using a robust encryption algorithm before storing it.
        if isBiometricEnabled {
            do {
                try KeychainHelper.saveToKeychain(credentials, server: server)
                showBioLoginView(true)
            } catch {
                handleError(error)
            }
        }
        if isSecuredBiometricEnabled {
            do {
                try SecuredKeychainHelper.addCredentials(credentials, server: server)
                showBioLoginView(true)
            } catch {
                handleError(error)
            }
        }
    }

    func logout() {
        do {
            try KeychainHelper.deleteFromKeychain(server: server)

            self.isLoggedIn = false
            self.authenticationError = nil
            showBioLoginView(false)
        } catch {
            handleError(error)
        }
        
    }

    func updateToggleA(_ value: Bool) {
        print("Value updated toggleA \(value)")
        isBiometricEnabled = value
        isSecuredBiometricEnabled = !value
        saveToggles()
    }
    
    func updateToggleB(_ value: Bool) {
        print("Value updated toggleB \(value)")
        isSecuredBiometricEnabled = value
        isBiometricEnabled = !value
        saveToggles()
    }

    func detectBiometricType() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            biometricType = context.biometryType
        } else {
            biometricType = .none
        }
    }

    func authenticateUser() {
        if isBiometricEnabled {
            unSecureAuth()
        }
        if isSecuredBiometricEnabled {
            securedAuth()
        }
    }
    private func validate() -> Bool {
        if username.count < 4 {
            withAnimation {
                usernameError = "Username must be at least 4 characters long."
            }
        }
        if password.count < 4 {
            withAnimation {
                passwordError = "Password must be at least 4 characters"
            }
        }
        if usernameError != nil || passwordError != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.usernameError = nil
                    self.passwordError = nil
                }
            }
            return false
        } else {
            return true
        }
    }
    private func saveToggles() {
        UserDefaults.standard.set(isBiometricEnabled, forKey: isBiometricEnabledKey)
        UserDefaults.standard.set(isSecuredBiometricEnabled, forKey: isSecuredBiometricEnabledKey)
    }

    private func showBioLoginView(_ value: Bool) {
        showBiometricsLoginView = value
        UserDefaults.standard.setValue(value, forKey: showBiometricsLoginViewKey)
    }
    private func unSecureAuth() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in to your account"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                guard let self else { return }
                if success {
                    // Handle successful authentication
                    do {
                        let credentials = try KeychainHelper.readFromKeychain(server: self.server)
                        self.login(with: credentials)
                    } catch {
                        self.handleError(error)
                    }
                } else {
                    // Handle failed authentication
                    self.handleError(authenticationError)
                }
            }
        } else {
            // Biometric authentication is not available
            self.handleError(error)
        }
    }
    private func securedAuth() {
        do {
            let credentials = try SecuredKeychainHelper.readCredentials(server: server)
            self.login(with: credentials)
        } catch {
            handleError(error)
        }
        
    }
    private func handleError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as? KeychainError {
                self.authenticationError = error.localizedDescription
            } else {
                self.authenticationError = error?.localizedDescription ?? "Failed to authenticate"
            }
        }
    }
    private func login(with credentials: Credentials) {
        // Call login API
        DispatchQueue.main.async {
            self.isLoggedIn = true
        }
    }
}
