//
//  APIClient.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 14.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Клиент для запроса в базу данных фильмов.
public protocol APIClient: AnyObject {
    
    /// Делает запрос с выбранным эндпоинтом.
    ///
    /// - Parameters:
    ///   - enpoint: Эндпоинт для обработки данных и формирования запроса.
    ///   - completionHandler: Вызывается после выполнения запроса. Возвращает ответ типа Endpoint.Content или ошибку.
    /// - Returns: Прогресс запроса.
    @discardableResult
    func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void
    ) -> Progress where T: Endpoint
}
