// RecipesDTO.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Types

/// DTO структура для рецепта
struct HitDTO: Codable {
    let recipe: RecipeDTO
}

/// DTO структура для рецепта
struct RecipeDTO: Codable {
    var label: String
    var uri: String
    var image: String
    var images: Images
    var calories: Double
    let totalWeight: Double
    let totalTime: Double
    let totalNutrients: [String: Total]
    let ingredientLines: [String]
}

/// DTO структура для изображений рецепта
struct Images: Codable {
    let thumbnail: Large
    let small: Large
    let regular: Large
    let large: Large?
    /// Перечисление для ключей кодирования и декодирования изображений рецепта
    enum CodingKeys: String, CodingKey {
        /// Ключ для миниатюрного изображения
        case thumbnail = "THUMBNAIL"
        /// Ключ для маленького изображения
        case small = "SMALL"
        /// Ключ для обычного изображения
        case regular = "REGULAR"
        /// Ключ для большого изображения
        case large = "LARGE"
    }
}

/// DTO структура для изображений большого размера
struct Large: Codable {
    let url: String
    let width, height: Int
}

/// DTO структура для общего количества
struct Total: Codable {
    let quantity: Double
}
