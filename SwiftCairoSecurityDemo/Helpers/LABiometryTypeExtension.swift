//
//  LABiometryTypeExtension.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import LocalAuthentication
extension LABiometryType {
    func biometricIconName() -> String {
        switch self {
        case .faceID:
            return "faceid"
        case .touchID:
            return "touchid"
        default:
            return "lock"
        }
    }
    func biometricButtonText() -> String {
        switch self {
        case .faceID:
            return "Login with Face ID"
        case .touchID:
            return "Login with Touch ID"
        default:
            return "Login with Biometric"
        }
    }
}
