// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol NetworkServiceProtocol {
    func getRecipes(completion: @escaping (Result<Recipes?, Error>) -> Void)
}

/// asdasdasd
final class NetworkService: NetworkServiceProtocol {
    func getRecipes(completion: @escaping (Result<Recipes?, Error>) -> Void) {
        let urlString =
            "https://api.edamam.com/api/recipes/v2?type=public&app_id=cfe9a239&app_key=5ed615922d17e88dbe36c5122d9cbd83&dishType=Soup"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("error was called")
                completion(.failure(error))
                return
            }

            guard let data else { return }

            do {
                let obj = try JSONDecoder().decode(Recipes.self, from: data)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
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
struct Recipes: Codable {
    let hits: [Hit]
}

/// asdasda
struct Hit: Codable {
    let recipe: Recipe
}

/// asdasda
struct Recipe: Codable {
    let label: String
    let image: String
    let calories: Double
    let totalWeight: Double
    let totalTime: Double
}
