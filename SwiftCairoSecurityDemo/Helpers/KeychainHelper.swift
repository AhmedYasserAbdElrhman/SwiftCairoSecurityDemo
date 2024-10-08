//
//  KeychainHelper.swift
//  SwiftCairoSecurityDemo
//
//  Created by Ahmed Yasser on 25/08/2024.
//

import Foundation
class KeychainHelper {
    static func saveToKeychain(_ credentials: Credentials, server: String) throws {
        // Use the username as the account, and get the password as data.
        let account = credentials.username
        let password = credentials.password.data(using: String.Encoding.utf8)!
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: account,
            kSecAttrServer as String: server,
            kSecValueData as String: password
        ]
        SecItemDelete(keychainQuery as CFDictionary) // Delete existing item if any
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError(status: status) }
        print("Data saved to Keychain")
    }
    static func readFromKeychain(server: String) throws -> Credentials {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: server,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: CFTypeRef? = nil
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess else { throw KeychainError(status: status) }

        guard let existingItem = dataTypeRef as? [String: Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let account = existingItem[kSecAttrAccount as String] as? String
            else {
                throw KeychainError(status: errSecInternalError)
        }
        return Credentials(username: account, password: password)
    }
    static func deleteFromKeychain(server: String) throws {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: server
        ]
        
        let status = SecItemDelete(keychainQuery as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError(status: status) }
        
        if status == errSecSuccess {
            print("Item successfully deleted from the keychain.")
        } else if status == errSecItemNotFound {
            print("No item found for the given server.")
        }
    }

}
