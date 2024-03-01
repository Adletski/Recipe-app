// RecipeModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Types

/// Модель для рецептов
struct RecipeCatalog {
    /// Словарь с названием блюд и изображенеим
    let categories: [DishCategory] = [
        DishCategory(imageName: "salad", type: .salad),
        DishCategory(imageName: "soup", type: .soup),
        DishCategory(imageName: "chicken", type: .chicken),
        DishCategory(imageName: "meat", type: .meat),
        DishCategory(imageName: "fish", type: .fish),
        DishCategory(imageName: "sideDish", type: .sideDish),
        DishCategory(imageName: "drinks", type: .drinks),
        DishCategory(imageName: "pancakes", type: .pancakes),
        DishCategory(imageName: "desserts", type: .desserts)
    ]
}
