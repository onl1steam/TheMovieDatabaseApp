//
//  AuthError.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

enum AuthError: Error {
    case blankFields
    case invalidData
    case unknownError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .blankFields:
            return "Не заполнены все поля"
        case .invalidData:
            return "Введен неверный логин или пароль"
        case .unknownError:
            return "Что-то пошло не так, попробуйте войти позже"
        }
    }
}
