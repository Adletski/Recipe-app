// LocalFileManager.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class LocalFileManager {
    static let instance = LocalFileManager()

//    func saveImage(image: UIImage, name: String) {
//        if let data = image.pngData() {
//            let fileName = getDocumentsDirectory().appendingPathComponent(name)
//            do {
//                try data.write(to: fileName)
//                print("success to save")
//            } catch {
//                print(error)
//                print("failed to save image")
//            }
//        }
//
    ////        guard let path = getPathForImage(name: name),
    ////              let data = image.jpegData(compressionQuality: 0.5) else { return }
    ////
    ////        do {
    ////            try data.write(to: path)
    ////            print("success saving!")
    ////        } catch {
    ////            print("Error saving. \(error)")
    ////        }
//    }

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
            print("patthhhh", path)
            print(path)
            try data.write(to: path)
            print("success")
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

        print("get image", path)
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

    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent("\(name).jpg")
        else {
            print("Error getting path.")
            return nil
        }
        return path
    }
}
