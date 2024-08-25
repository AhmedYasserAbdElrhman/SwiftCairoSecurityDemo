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
        }
        .padding()
    }
}
#Preview {
    LoginView()
        .environmentObject(LoginManager())
}
