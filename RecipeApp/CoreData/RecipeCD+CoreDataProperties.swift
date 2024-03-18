// RecipeCD+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation
import UIKit

/// Модель данных рецепта, сохраняемая в Core Data
@objc(RecipeCD)
public class RecipeCD: NSManagedObject {}

/// Расширение для управления атрибутами сущности RecipeCD
public extension RecipeCD {
    /// URI рецепта
    @NSManaged var uri: String?
    /// Название рецепта
    @NSManaged var label: String?
    /// Ссылка на изображение рецепта
    @NSManaged var image: String?
    /// Количество калорий
    @NSManaged var calories: String?
    /// Общее время приготовления
    @NSManaged var totalTime: String?
}
/// Расширение для  RecipeCD, делает ее поддерживаемой идентификацией
extension RecipeCD: Identifiable {}
/// Менеджер Core Data для работы с данными рецептов
final class CoreDataManager {
    static let shared = CoreDataManager()
    /// Приватный инициализатор для соблюдения паттерна Singleton
    private init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    // MARK: - Public Methods
    /// Метод для вывода пути к базе данных Core Data
    func logCoreDataDBPath() {
        if let url = appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
            print("DB url - \(url)")
        }
    }
    /// Создание нового рецепта и сохранение его в Core Data
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
    /// Получение всех сохраненных рецептов из Core Data
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
    /// Получение рецепта по его имени из Core Data
    func fetchRecipe(name: String) -> RecipeCD? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeCD")
        do {
            guard let recipes = try? context.fetch(fetchRequest) as? [RecipeCD] else { return RecipeCD() }
            return recipes.first { $0.entity.name == name }
        }
    }
    /// Обновление рецепта в Core Data
    func updateRecipe(with name: String) {}
    /// Удаление всех рецептов из Core Data
    func deleteAllPhoto() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeCD")
        do {
            let recipes = try? context.fetch(fetchRequest) as? [RecipeCD]
            recipes?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
}
