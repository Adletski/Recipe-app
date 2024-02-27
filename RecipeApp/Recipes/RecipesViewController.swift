// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RecipesView: AnyObject {}

final class RecipesViewController: UIViewController, RecipesView {
    var presenter: RecipesPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
