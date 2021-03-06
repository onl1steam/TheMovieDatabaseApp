//
//  NetworkError.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    
    case badURL
    case unauthorized
    case notFound
    case unknownError
    case invalidApiKey
    case decodingError
    case encodingError
    case blankData
    case invalidImage
    case notHTTPResponse
    case noConfiguration
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Неверно задан URL запроса.", comment: "Unauthorized error")
        case .unauthorized:
            return NSLocalizedString("Произошла ошибка при авторизации.", comment: "Unauthorized error")
        case .notFound:
            return NSLocalizedString("Запрашиваемый ресурс не найден.", comment: "Page not found error")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка, попробуйте позже.", comment: "Unknown error")
        case .invalidApiKey:
            return NSLocalizedString("Введен неверный API ключ.", comment: "Unknown error")
        case .decodingError:
            return NSLocalizedString("Возвращен неверный формат данных.", comment: "Decoding error")
        case .encodingError:
            return NSLocalizedString("Введен неверный формат данных.", comment: "Decoding error")
        case .blankData:
            return NSLocalizedString("Запрос не вернул данных.", comment: "Blank data error")
        case .invalidImage:
            return NSLocalizedString("Неверный формат изображения.", comment: "Blank data error")
        case .notHTTPResponse:
            return NSLocalizedString("Ответ не является HTTP ответом.", comment: "No HTTP Response error")
        case .noConfiguration:
            return NSLocalizedString("Нет настроек запроса в Configuration.", comment: "No Configuration error")
        }
    }
}

extension NetworkError: Equatable {}
