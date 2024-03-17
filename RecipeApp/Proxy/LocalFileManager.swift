// LocalFileManager.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class LocalFileManager {
    static let instance = LocalFileManager()

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

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
}
