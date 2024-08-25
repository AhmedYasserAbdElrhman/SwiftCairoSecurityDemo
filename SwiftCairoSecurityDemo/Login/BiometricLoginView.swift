//
//  BiometricLoginView.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import SwiftUI

struct BiometricLoginView: View {
    @EnvironmentObject var loginManager: LoginManager
    var body: some View {
        VStack(spacing: 30) {
            // Welcome text
            Text("Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            // Biometric icon and button
            VStack(spacing: 20) {
                Image(systemName: loginManager.biometricType.biometricIconName())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.primary)

                Button(action: {
                    loginManager.authenticateUser()
                }) {
                    Text(loginManager.biometricType.biometricButtonText())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)

            if let error = loginManager.authenticationError {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top, 10)
                Button(action: {
                    // Handle logout action
                    loginManager.logout()
                }) {
                    HStack {
                        Image(systemName: "power")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding()

            }

        }
        .onAppear {
            loginManager.detectBiometricType()
        }
    }
}

#Preview {
    BiometricLoginView()
        .environmentObject(LoginManager())
}
