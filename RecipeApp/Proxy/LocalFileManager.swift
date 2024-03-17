// LocalFileManager.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Менеджер локального файла для сохранения и получения изображений
final class LocalFileManager {
    static let instance = LocalFileManager()

    // MARK: - Public Methods

    /// Сохраняет изображение в локальный файл
    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return
        }
        guard let directory = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) as NSURL else {
            return
        }
        do {
            guard let path = directory.appendingPathComponent(name) else { return }
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Получает изображение из локального файла
    func getImage(name: String) -> Data? {
        guard let directory = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) as NSURL else {
            return Data()
        }
        guard let path = directory.appendingPathComponent(name) else { return Data() }

        do {
            return try Data(contentsOf: path)
        } catch {
            print(error)
        }
        return nil
    }

    /// Директория документов приложения
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
}
