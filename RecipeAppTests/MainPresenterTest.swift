// MainPresenterTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import RecipeApp
import XCTest

class MockView: RecipesView {}

final class MainPresenterTest: XCTestCase {
    var view: RecipesView!
    var recipe: RecipeModel!
    var presenter: RecipesPresenter!

    override func setUpWithError() throws {
        view = MockView()
        recipe = RecipeModel(title: "hello")
        presenter = RecipesPresenterImpl()
    }

    override func tearDownWithError() throws {
        view = nil
        recipe = nil
        presenter = nil
    }

    func testModuleIsNotNil() throws {
        XCTAssertNotNil(view, "view is not nil")
    }
}
