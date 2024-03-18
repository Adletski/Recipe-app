// KeychainManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ettd
enum KeychainError: Error {
    case duplicateItem
    case unknown(status: OSStatus)
}

final class KeychainManager {
    static func save(password: Data, account: String) throws -> Bool {
        let queryMap: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: password
        ]

        let status = SecItemAdd(queryMap as CFDictionary, nil)

        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }

        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }

        return true
    }

    static func getPassword(for account: String) throws -> Data? {
        let queryMap: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any
        ]

        var result: AnyObject?

        let status = SecItemCopyMatching(queryMap as CFDictionary, &result)

        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }

        return result as? Data
    }
}
