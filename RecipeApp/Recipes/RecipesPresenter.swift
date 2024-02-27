// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RecipesPresenter {
    var view: RecipesView! { get set }
    var coordinator: Coordinator! { get set }
}

final class RecipesPresenterImpl: RecipesPresenter {
    weak var coordinator: Coordinator!
    weak var view: RecipesView!
}
