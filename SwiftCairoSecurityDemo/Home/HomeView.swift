//
//  HomeView.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var loginManager: LoginManager

    var body: some View {
        VStack {
            Text("Home Screen")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            if loginManager.isBiometricEnabled {
                Text("😕")
                    .font(.system(size: 100))
            }
            if loginManager.isSecuredBiometricEnabled {
                Text("🤝")
                    .font(.system(size: 100))

            }
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

            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}
#Preview {
    HomeView()
        .environmentObject(LoginManager())
}
