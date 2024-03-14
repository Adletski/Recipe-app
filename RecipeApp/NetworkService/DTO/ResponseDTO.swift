// ResponseDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Types

/// Структура для декодирования JSON-ответа от сервера
struct ResponseDTO: Codable {
    /// Массив объектов содержащий информацию о рецептах
    let hits: [HitDTO]
}
