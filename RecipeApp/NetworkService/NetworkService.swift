// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Types

/// Протокол для работы с сетью
protocol NetworkServiceProtocol {
    /// Получение рецептов
    func getRecipes(dishType: String, completion: @escaping (Result<[Recipe], Error>) -> Void)
    /// Получение детальной информации о рецепте по URI
    func getDetailRecipe(uri: String, completion: @escaping (Result<DetaliesResipe, Error>) -> Void)

    /// Загрузка изображения по URL
    static func downLoadImage(_ urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void)
    var proxy: Proxy { get set }
}

/// Класс  для работы с сетью
final class NetworkService: NetworkServiceProtocol {
    let baseURL = "https://api.edamam.com/api/recipes/v2"
    let appID = "cfe9a239"
    let appKey = "5ed615922d17e88dbe36c5122d9cbd83"
    let dishType = "Soup"

    private let imageService = LoadImageService()
    lazy var proxy = Proxy(service: imageService)

    // MARK: - Public Methods

    /// Получение рецептов
    func getRecipes(dishType: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "app_id", value: appID),
            URLQueryItem(name: "app_key", value: appKey),
            URLQueryItem(name: "dishType", value: dishType)
        ]
        guard let url = components?.url else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error occurred: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                var recipes: [Recipe] = []
                let responseDTO = try JSONDecoder().decode(ResponseDTO.self, from: data)
                responseDTO.hits.forEach { recipes.append(Recipe(dto: $0.recipe)) }
                completion(.success(recipes))
            } catch {
                print("Error decoding data: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }

    /// Получение детальной информации о рецепте
    func getDetailRecipe(uri: String, completion: @escaping (Result<DetaliesResipe, Error>) -> Void) {
        var components = URLComponents(string: baseURL + "/by-uri")
        components?.queryItems = [
            URLQueryItem(name: "app_key", value: appKey),
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "app_id", value: appID),
            URLQueryItem(name: "uri", value: uri)
        ]

        guard let url = components?.url else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error occurred: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let responseDTO = try JSONDecoder().decode(ResponseDTO.self, from: data)
                guard let detailRecipeDTO = responseDTO.hits.first?.recipe else { return }
                completion(.success(DetaliesResipe(dto: detailRecipeDTO)))
            } catch {
                print("Error decoding data: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }

    /// Загрузка изображения по URL
    static func downLoadImage(_ urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Error occurred: \(error)")
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
