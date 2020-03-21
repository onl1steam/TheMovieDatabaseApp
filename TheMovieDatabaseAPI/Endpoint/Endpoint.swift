//
//  Endpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 14.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для формирования запроса и обработки полученных данных.
public protocol Endpoint {
    
    /// Возвращаемый тип данных.
    associatedtype Content
    
    /// Формирует запрос.
    ///
    /// - Returns: Запрос типа URLRequest.
    func makeRequest() throws -> URLRequest
    
    /// Проверяет полученные данные на API, HTTP ошибки и обрабатывает данные. В случае успеха возвращает данные.
    ///
    /// - Parameters:
    ///   - from: Полученные данные типа Data.
    ///   - response: Ответ на зарос типа URLResponse.
    /// - Returns: Данные типа Content.
    func content(from: Data?, response: URLResponse?) throws -> Content
    
    /// Настройки подключения к базе данных фильмов.
    var configuration: Configuration? { get set }
}
