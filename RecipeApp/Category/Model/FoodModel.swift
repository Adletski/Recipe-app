// FoodModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Constants

private enum Constants {
    static let descriptions = """
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes
    """
}

/// Модель для ячеек с едой
struct FoodModel {
    let image: String
    let name: String
    let title: String
    let time: String
    let kkal: String
    /// Вес
    let weight: Int
    /// Углеводы
    let carbohydrates: Float
    /// Жиры
    let fats: Float
    /// Белки
    let proteins: Float
    /// Описание рецепта
    let descriptions: String

    /// свойство типа с мок-данными
    static let fishRecipes: [FoodModel] = [
        FoodModel(
            image: "recipe",
            name: "Simple Fish And Corn",
            time: "60",
            kkal: "1322",
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        FoodModel(
            image: "recipe",
            name: "Some fish",
            time: "60",
            kkal: "1322",
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        FoodModel(
            image: "recipe",
            name: "x3 Fish",
            time: "60",
            kkal: "1322",
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        FoodModel(
            image: "recipe",
            name: "Double fish",
            time: "60",
            kkal: "1322",
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
        FoodModel(
            image: "recipe",
            name: "No fish",
            time: "60",
            kkal: "1322",
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
    ]

    static let otherRecipes: [FoodModel] = [
        FoodModel(
            image: "recipe",
            name: "Some meal",
            time: "60",
            kkal: "1322",
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.30,
            descriptions: Constants.descriptions
        ),
    ]
    /// метод типа для получения данных
    static func getRecipes(category: DishCategory) -> [FoodModel] {
        switch category.type {
        case .fish:
            return FoodModel.fishRecipes
        default:
            return FoodModel.otherRecipes
        }
    }

    init(
        image: String = "",
        name: String = "",
        title: String = "",
        time: String = "",
        kkal: String = "",
        weight: Int? = nil,
        carbohydrates: Float? = nil,
        fats: Float? = nil,
        proteins: Float? = nil,
        descriptions: String? = nil
    ) {
        self.image = image
        self.name = name
        self.title = title
        self.time = time
        self.kkal = kkal
        self.weight = weight ?? 0
        self.carbohydrates = carbohydrates ?? 0.0
        self.fats = fats ?? 0.0
        self.proteins = proteins ?? 0.0
        self.descriptions = descriptions ?? ""
    }
}
