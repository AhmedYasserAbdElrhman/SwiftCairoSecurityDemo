//
//  ContentView.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 23/08/2024.
//

import SwiftUI
import LocalAuthentication
struct ContentView: View {
    @StateObject private var loginManager = LoginManager()

    var body: some View {
        NavigationView {
            if loginManager.isLoggedIn {
                HomeView()
                    .environmentObject(loginManager)
            } else {
                LoginView()
                    .environmentObject(loginManager)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensures the correct behavior on all devices
    }
}

#Preview {
    ContentView()
}
