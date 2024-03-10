// UserDefaultsManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

class UserInfo: NSObject, NSCoding {
    let name: String
    let surname: String
    let login: String
    let password: String

    init(name: String, surname: String, login: String, password: String) {
        self.name = name
        self.surname = surname
        self.login = login
        self.password = password
    }

    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(surname, forKey: "surname")
        coder.encode(login, forKey: "login")
        coder.encode(password, forKey: "password")
    }

    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        surname = coder.decodeObject(forKey: "surname") as? String ?? ""
        login = coder.decodeObject(forKey: "login") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
    }
}

class RecipeModel: NSObject, NSCoding {
    let title: String
    let time: String
    let kkal: String

    init(title: String, time: String, kkal: String) {
        self.title = title
        self.time = time
        self.kkal = kkal
    }

    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(time, forKey: "time")
        coder.encode(kkal, forKey: "kkal")
    }

    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as? String ?? ""
        time = coder.decodeObject(forKey: "time") as? String ?? ""
        kkal = coder.decodeObject(forKey: "kkal") as? String ?? ""
    }
}

final class UserSettings {
    private enum SettingsKey: String {
        case userInfo
        case recipes
    }

    static var userInfo: UserInfo! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKey.userInfo.rawValue) as? Data,
                  let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserInfo
            else {
                return nil
            }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.userInfo.rawValue

            if let userInfo = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(
                    withRootObject: userInfo,
                    requiringSecureCoding: false
                ) {
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
}
