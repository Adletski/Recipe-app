// LoadService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol LoadServiceProtocol {
    func loadImage(name: String, url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

final class LoadImageService: LoadServiceProtocol {
    func loadImage(name: String, url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        let session = URLSession(configuration: config)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}

final class Proxy: LoadServiceProtocol {
    private let service: LoadServiceProtocol
    let manager = LocalFileManager.instance

    init(service: LoadServiceProtocol) {
        self.service = service
    }

    func loadImage(name: String, url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let cacheData = manager.getImage(name: String(name.suffix(32)))
        print(cacheData, "cachedata printing")
        if cacheData == nil {
            service.loadImage(name: name, url: url) { data, response, error in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }

                self.manager.saveImage(image: image, name: String(name.suffix(32)))
                completion(data, response, error)
            }
        } else {
            print("data from cache")
            completion(cacheData, nil, nil)
        }
    }
}

// func loadImage() {
//    let imageView = UIImageView()
//
//    let imageService = LoadImageService()
//    let proxy = Proxy(service: imageService)
//    let url = URL(string: "https://oboi-download.ru/files/wallpapers/1457/30349.jpg")!
//
//    proxy.loadImage(url: url) { [weak self] data, response, error in
//        guard let self = self, let data = data, error == nil else { return }
//        DispatchQueue.main.async {
//            self.imageView.image = UIImage(data: data)
//        }
//    }
// }
