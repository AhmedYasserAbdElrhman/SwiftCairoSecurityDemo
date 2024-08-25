//
//  KeychainError.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import Foundation
struct KeychainError: Error {
    var status: OSStatus
    var localizedDescription: String {
        return SecCopyErrorMessageString(status, nil) as String? ?? "Unknown error."
    }
}
