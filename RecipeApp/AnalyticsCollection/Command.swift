// Command.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Комманд
final class Command {
    private let action: LogActions
    
    var logMessages: String {
        switch action {
        case .openRecipe:
            return "Пользователь открыл “Экран рецептов”"
        case .openCatagoryOfRecipe:
            return "Пользовать перешел на ”Экран со списком рецептов из Рыбы”"
        case .openDescriptionsRecipe:
            return "Пользователь открыл рецепт блюда из семги"
        case .tapShareButton:
            return "Пользователь поделился рецептом из семги"
        }
    }
    
    init(action: LogActions) {
        self.action = action
    }
}
