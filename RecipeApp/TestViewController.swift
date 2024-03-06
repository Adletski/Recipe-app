// TestViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Visual Components

/// Класс тестового контроллера для демонстрации SortingViewControl
final class TestViewController: UIViewController {
    let customView = SortingViewControl()
    var names = ["Calories", "Time"]

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.dataSource = self
        view.addSubview(customView)

        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - extension SortingPickerDataSource

extension TestViewController: SortingPickerDataSource {
    /// Возвращает количество элементов в контроле выбора сортировки
    func sortPickerCount(_ dayPicker: SortingViewControl) -> Int {
        names.count
    }

    /// Возвращает заголовок элемента сортировки для указанного индекса
    func sortPickerTitle(_ dayPicker: SortingViewControl, indexPath: IndexPath) -> String {
        names[indexPath.row]
    }
}
