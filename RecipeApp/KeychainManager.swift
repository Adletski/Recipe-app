// KeychainManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
//MARK: - Types
/// Перечисления для ошибок
enum KeychainError: Error {
    /// Ошибка дублирования элемента
    case duplicateItem
    /// Неизвестная ошибка с указанным статусом
    case unknown(status: OSStatus)
}
/// Класс, отвечающий за управление данными в Keychain
final class KeychainManager {
    // MARK: - Public Methods
    /// Сохранение пароля в Keychain
    static func save(password: Data, account: String) throws -> Bool {
        let queryMap: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: password
        ]

        let status = SecItemAdd(queryMap as CFDictionary, nil)

        guard status != errSecDuplicateItem else {
            /// Выброс исключения в случае дублирования элемента
            throw KeychainError.duplicateItem
        }

        guard status == errSecSuccess else {
            /// Выброс исключения в случае неизвестной ошибки с указанным статусом
            throw KeychainError.unknown(status: status)
        }

        return true
    }
    /// Получение пароля из Keychain по имени аккаунта
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
