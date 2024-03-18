// RecipeCD+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation
import UIKit

/// asdasd
@objc(RecipeCD)
public class RecipeCD: NSManagedObject {}

/// asdasd
public extension RecipeCD {
    @NSManaged var uri: String?
    @NSManaged var label: String?
    @NSManaged var image: String?
    @NSManaged var calories: String?
    @NSManaged var totalTime: String?
}

extension RecipeCD: Identifiable {}

final class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    func logCoreDataDBPath() {
        if let url = appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
            print("DB url - \(url)")
        }
    }

    func createRecipe(uri: String, label: String, image: String, calories: String, totalTime: String) {
        guard let recipeEntityDescription = NSEntityDescription.entity(forEntityName: "RecipeCD", in: context) else {
            print("recipe entity description failed")
            return
        }
        let recipeCD = RecipeCD(entity: recipeEntityDescription, insertInto: context)
        recipeCD.calories = calories
        recipeCD.uri = uri
        recipeCD.label = label
        recipeCD.image = image
        recipeCD.totalTime = totalTime

        appDelegate.saveContext()
    }

    func fetchRecipes() -> [RecipeCD] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeCD")
        do {
            return try (context.fetch(fetchRequest) as? [RecipeCD]) ?? []
        } catch {
            print("fetch recipes called")
            print(error.localizedDescription)
        }

        return []
    }

    func fetchRecipe(name: String) -> RecipeCD? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeCD")
        do {
            guard let recipes = try? context.fetch(fetchRequest) as? [RecipeCD] else { return RecipeCD() }
            return recipes.first { $0.entity.name == name }
        }
    }

    func updateRecipe(with name: String) {}

    func deleteAllPhoto() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeCD")
        do {
            let recipes = try? context.fetch(fetchRequest) as? [RecipeCD]
            recipes?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
}
