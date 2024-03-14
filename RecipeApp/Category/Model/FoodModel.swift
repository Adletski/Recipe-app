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
struct FoodModel: Codable {
    /// Название изображения блюда
    let image: String
    /// Название блюда
    let name: String
    /// Заголовок блюда
    let title: String
    /// Время приготовления блюда
    let time: String
    /// Время приготовления блюда в минутах
    let timeCount: Int
    /// Количество калорий блюда (текст)
    let kkal: String
    /// Количество калорий блюда (число)
    let kkalCount: Int
    /// Вес
    let weight: Int
    /// Углеводы
    let carbohydrates: String
    /// Жиры
    let fats: String
    /// Белки
    let proteins: String
    /// Описание рецепта
    let descriptions: String

    // MARK: - Static Properties

//    /// свойство типа с мок-данными
//    static let fishRecipes: [FoodModel] = [
//        FoodModel(
//            image: "recipe",
//            name: "Simple Fish And Corn",
//            time: "60",
//            timeCount: 60, kkal: "1322",
//            kkalCount: 1322, weight: 793,
//            carbohydrates: 10.78,
//            fats: 10.00,
//            proteins: 97.30,
//            descriptions: Constants.descriptions
//        ),
//        FoodModel(
//            image: "recipe",
//            name: "Some fish",
//            time: "60",
//            timeCount: 60, kkal: "1322",
//            kkalCount: 1322, weight: 793,
//            carbohydrates: 10.78,
//            fats: 10.00,
//            proteins: 97.30,
//            descriptions: Constants.descriptions
//        ),
//        FoodModel(
//            image: "recipe",
//            name: "x3 Fish",
//            time: "60",
//            timeCount: 60, kkal: "1322",
//            kkalCount: 1322, weight: 793,
//            carbohydrates: 10.78,
//            fats: 10.00,
//            proteins: 97.30,
//            descriptions: Constants.descriptions
//        ),
//        FoodModel(
//            image: "recipe",
//            name: "Double fish",
//            time: "60",
//            timeCount: 60, kkal: "1322",
//            kkalCount: 1322, weight: 793,
//            carbohydrates: 10.78,
//            fats: 10.00,
//            proteins: 97.30,
//            descriptions: Constants.descriptions
//        ),
//        FoodModel(
//            image: "recipe",
//            name: "No fish",
//            time: "60",
//            timeCount: 60, kkal: "1322",
//            kkalCount: 1322,
//            weight: 793,
//            carbohydrates: 10.78,
//            fats: 10.00,
//            proteins: 97.30,
//            descriptions: Constants.descriptions
//        ),
//    ]

//    static let otherRecipes: [FoodModel] = [
//        FoodModel(
//            image: "recipe",
//            name: "Some meal",
//            time: "60",
//            timeCount: 60, kkal: "1322",
//            kkalCount: 1322, weight: 793,
//            carbohydrates: 10.78,
//            fats: 10.00,
//            proteins: 97.30,
//            descriptions: Constants.descriptions
//        ),
//    ]

    // MARK: - Static Methods

//    /// метод типа для получения данных
//    static func getRecipes(category: DishCategory) -> [FoodModel] {
//        switch category.type {
//        case .fish:
//            return FoodModel.fishRecipes
//        default:
//            return FoodModel.otherRecipes
//        }
//    }

    // MARK: - Initializers

    init(
        image: String = "",
        name: String = "",
        title: String = "",
        time: String = "",
        timeCount: Int = 0,
        kkal: String = "",
        kkalCount: Int = 0,
        weight: Int? = nil,
        carbohydrates: String? = nil,
        fats: String? = nil,
        proteins: String? = nil,
        descriptions: String? = nil
    ) {
        self.image = image
        self.name = name
        self.title = title
        self.time = time
        self.timeCount = timeCount
        self.kkal = kkal
        self.kkalCount = kkalCount
        self.weight = weight ?? 0
        self.carbohydrates = carbohydrates ?? ""
        self.fats = fats ?? ""
        self.proteins = proteins ?? ""
        self.descriptions = descriptions ?? ""
    }
}
