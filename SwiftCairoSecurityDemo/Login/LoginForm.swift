//
//  LoginForm.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import SwiftUI

struct LoginForm: View {
    @EnvironmentObject var loginManager: LoginManager
    var body: some View {
        ScrollView {
            VStack {
                Text("Signup")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                TextField("Username", text: $loginManager.username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                if let usernameError = loginManager.usernameError {
                    Text(usernameError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 5)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: loginManager.usernameError)
                }
                SecureField("Password", text: $loginManager.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                if let passwordError = loginManager.passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 5)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.3), value: loginManager.passwordError)
                }
                Toggle("Enable Biometric Login", isOn: $loginManager.isBiometricEnabled)
                    .padding()
                    .onChange(of: loginManager.isBiometricEnabled) { newValue in
                        loginManager.updateToggleA(newValue)
                    }
                Toggle("Enable Secured Biometric Login", isOn: $loginManager.isSecuredBiometricEnabled)
                    .padding()
                    .onChange(of: loginManager.isSecuredBiometricEnabled) { newValue in
                        loginManager.updateToggleB(newValue)
                    }
                Button(action: {
                    loginManager.creatAccount()
                }) {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                if let error = loginManager.authenticationError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    LoginForm()
}
