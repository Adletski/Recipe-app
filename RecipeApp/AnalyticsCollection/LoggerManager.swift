// LoggerManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// реализация логгера
protocol LoggerManagerProtocol {
    ///фунция для вызова добавления в логгер
    func log(_ action: LogActions)
}

/// Логер Менеджер
final class LoggerManager: LoggerManagerProtocol {
    func log(_ action: LogActions) {
        let command = Command(action: action)
        LoggerInvoker.shared.addLogCommand(command)
    }
}
