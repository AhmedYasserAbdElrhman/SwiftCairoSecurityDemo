//
//  LoginView.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginManager: LoginManager
    var body: some View {
        NavigationView {
            if loginManager.showBiometricsLoginView {
                BiometricLoginView()
                    .environmentObject(loginManager)
            } else {
                LoginForm()
                    .environmentObject(loginManager)
            }
            if let error = loginManager.authenticationError {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
        }
        .padding()
    }
}
#Preview {
    LoginView()
        .environmentObject(LoginManager())
}
