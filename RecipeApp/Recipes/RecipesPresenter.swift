// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентера рецептов
protocol RecipesPresenter {
    var view: RecipesView! { get set }
}

/// Презентер для рецептов
final class RecipesPresenterImpl: RecipesPresenter {
    // MARK: - Properties

    weak var view: RecipesView!
}
