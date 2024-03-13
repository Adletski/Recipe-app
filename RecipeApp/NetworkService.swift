// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol NetworkServiceProtocol {
    func getRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void)
}

/// asdasdasd
final class NetworkService: NetworkServiceProtocol {
    func getRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.edamam.com/api/recipes/v2"
        let queryItemType = URLQueryItem(name: "type", value: "public")
        let queryItemAppId = URLQueryItem(name: "app_id", value: "cfe9a239")
        let queryItemAppKey = URLQueryItem(name: "app_key", value: "5ed615922d17e88dbe36c5122d9cbd83")
        let queryItemDishType = URLQueryItem(name: "dishType", value: "Soup")
        components.queryItems = [queryItemType, queryItemAppId, queryItemAppKey]

        guard let url = components.url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("error was called")
                completion(.failure(error))
                return
            }

            guard let data else { return }

            do {
                var recipes: [Recipe] = []
                let obj = try JSONDecoder().decode(RecipesDTO.self, from: data)
                for hit in obj.hits {
                    recipes.append(Recipe(dto: hit.recipe))
                }

                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func getDetailRecipe(uri: String, completion: @escaping (Result<Recipe, Error>) -> Void) {
        let urlString =
            "https://api.edamam.com/api/recipes/v2/by-uri?app_key=5ed615922d17e88dbe36c5122d9cbd83&type=public&app_id=cfe9a239&uri=\(uri)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("errow was called")
                completion(.failure(error))
                return
            }

            guard let data else { return }

            do {
                let obj = try JSONDecoder().decode(RecipesDTO.self, from: data)
                if let recipe = obj.hits.first?.recipe {
                    completion(.success(Recipe(dto: recipe)))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    static func downLoadImage(_ urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("error was called")
                    completion(.failure(error))
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                    return
                }
            }.resume()
        }
    }
}

/// asdasda
struct RecipesDTO: Codable {
    let hits: [HitDTO]
}

/// asdasda
struct HitDTO: Codable {
    let recipe: RecipeDTO
}

/// asdasda
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

/// asdasda
struct Recipe: Identifiable {
    var id: String
    var uri: String
    var label: String
    var image: String
    var images: String
    var calories: String
    var totalWeight: String
    var totalTime: String
    var energy: Double
    var carbohydrates: Double
    var fat: Double
    var proteins: Double

    init(dto: RecipeDTO) {
        id = "1"
        label = dto.label
        image = dto.image
        calories = "\(Int(dto.calories)) kkal"
        totalWeight = "\(Int(dto.totalWeight)) g"
        totalTime = "\(Int(dto.totalTime)) min"
        uri = dto.uri
        images = dto.images.regular.url
        energy = dto.totalNutrients["ENERC_KCAL"]?.quantity ?? 0.0
        carbohydrates = dto.totalNutrients["CHOCDF"]?.quantity ?? 0.0
        fat = dto.totalNutrients["FAT"]?.quantity ?? 0.0
        proteins = dto.totalNutrients["PROCNT"]?.quantity ?? 0.0
    }
}

/// asdasdasd
struct Images: Codable {
    let thumbnail: Large
    let small: Large
    let regular: Large
    let large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

/// asdasdasd
struct Large: Codable {
    let url: String
    let width, height: Int
}

/// asdasdasd
struct Total: Codable {
    let quantity: Double
}
