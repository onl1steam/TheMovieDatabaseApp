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
    case decodingError
    case encodingError
    case blankData
}

extension NetworkError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return NSLocalizedString("Неверно задан URL запроса.", comment: "Unauthorized error")
        case .unauthorized:
            return NSLocalizedString("Неверные данные пользователя.", comment: "Unauthorized error")
        case .notFound:
            return NSLocalizedString("Запрашиваемый ресурс не найден.", comment: "Page not found error")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка, попробуйте позже.", comment: "Unknown error")
        case .decodingError:
            return NSLocalizedString("Возвращен неверный формат данных.", comment: "Decoding error")
        case .encodingError:
            return NSLocalizedString("Введен неверный формат данных.", comment: "Decoding error")
        case .blankData:
            return NSLocalizedString("Запрос не вернул данных.", comment: "Blank data error")
        }
    }
}
