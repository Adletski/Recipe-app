// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UserDefaults.standard.set("1@mail.ru", forKey: "login")
        UserDefaults.standard.set("qwerty", forKey: "password")

//        CoreDataManager.shared.logCoreDataDBPath()
        CoreDataManager.shared.createRecipe(
            uri: "asdasd",
            label: "adlet",
            image: "asdads",
            calories: "200 kkal",
            totalTime: "100 min"
        )

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // это как база данных на жестком диске
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url - ", description.url?.absoluteString)
            }
        }
        return container
    }()

    // это как слепок с которым мы работаем, копия с персистентконтейнера
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                // сохранение в персистент контейнер
                try context.save()
            } catch {
                let error = error as? NSError
                fatalError(error?.localizedDescription ?? "")
            }
        }
    }
}
