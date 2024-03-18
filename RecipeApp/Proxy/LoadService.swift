// LoadService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для загрузки изображений
protocol LoadServiceProtocol {
    /// Метод для загрузки изображения по заданному имени и URL.
    func loadImage(name: String, url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

/// Сервис для загрузки изображений из сети
final class LoadImageService: LoadServiceProtocol {
    /// Загружает изображение из сети
    func loadImage(name: String, url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        let session = URLSession(configuration: config)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}

/// Прокси-сервис для загрузки изображений с возможностью кэширования
final class Proxy: LoadServiceProtocol {
    private let service: LoadServiceProtocol
    let manager = LocalFileManager.instance
    /// Инициализирует Proxy с внутренним сервисом загрузки
    init(service: LoadServiceProtocol) {
        self.service = service
    }

    /// Загружает изображение. Если изображение присутствует в кэше, загружается из него, иначе загружается из сети
    func loadImage(name: String, url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let cacheData = manager.getImage(name: String(name.suffix(32)))
        if cacheData == nil {
            service.loadImage(name: name, url: url) { data, response, error in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }

                self.manager.saveImage(image: image, name: String(name.suffix(32)))
                completion(data, response, error)
            }
        } else {
            completion(cacheData, nil, nil)
        }
    }
}
