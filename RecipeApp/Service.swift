// Service.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Service {
    func getCategoryList() -> [FoodModel] {
        [
            FoodModel(image: "food1", name: "Simple Fish And Corn", time: "60 min", kkal: "274 kkal"),
            FoodModel(image: "food2", name: "Fast Roast Fish & Show Peas Recipes", time: "80 min", kkal: "94 kkal"),
            FoodModel(image: "food3", name: "Lemon and Chili Fish Fish Burrito", time: "90 min", kkal: "226 kkal"),
            FoodModel(image: "food4", name: "Baked Fish with Lemon Herb Sauce", time: "90 min", kkal: "616 kkal"),
            FoodModel(
                image: "food5",
                name: "Salmon with Cantaloupe and Fried Shallots",
                time: "100 min",
                kkal: "410 kkal"
            ),
            FoodModel(image: "food6", name: "Chili and Tomato Fish", time: "100 min", kkal: "174 kkal"),
        ]
    }
}
