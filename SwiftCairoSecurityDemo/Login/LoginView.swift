//
//  LoginView.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginManager: LoginManager
    @State private var username = ""
    @State private var password = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
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
                        loginManager.login(username: username, password: password)
                        loginManager.isLoggedIn = true
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    Spacer()
            }
        }
        .padding()
    }
}
#Preview {
    LoginView()
        .environmentObject(LoginManager())
}
