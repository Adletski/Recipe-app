// RecipesAndDetaliesModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Types

/// Модель рецепта
struct Recipe {
    var uri: String
    var label: String
    var image: String
    var calories: String
    var totalTime: String
    /// Инициализация модели рецепта
    init(dto: RecipeDTO) {
        label = dto.label
        image = dto.image
        calories = "\(Int(dto.calories)) kkal"
        totalTime = "\(Int(dto.totalTime)) min"
        uri = dto.uri
    }
}

/// Модель для деталей
struct DetaliesResipe {
    var label: String
    var imagesUrl: String
    var totalWeight: String
    var totalTime: String
    var calories: String
    var carbohydrates: String
    var fats: String
    var proteins: String
    var ingredients: [String]
    /// Инициализация модели рецепта
    init(dto: RecipeDTO) {
        label = dto.label
        imagesUrl = dto.images.regular.url
        totalWeight = "\(Int(dto.totalWeight)) g"
        totalTime = "\(Int(dto.totalTime)) min"
        calories = "\(Int(dto.totalNutrients["ENERC_KCAL"]?.quantity ?? 0)) kcal"
        carbohydrates = "\(Int(dto.totalNutrients["CHOCDF"]?.quantity ?? 0)) g"
        fats = "\(Int(dto.totalNutrients["FAT"]?.quantity ?? 0)) g"
        proteins = "\(Int(dto.totalNutrients["PROCNT"]?.quantity ?? 0)) g"
        ingredients = dto.ingredientLines
    }
}
