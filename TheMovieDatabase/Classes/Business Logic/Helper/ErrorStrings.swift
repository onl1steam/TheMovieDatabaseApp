//
//  ErrorScreenStrings.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

enum ErrorStrings {
    
    static let blankFields = NSLocalizedString("Не заполнены все поля", comment: "Blank Fields")
    static let invalidInput = NSLocalizedString("Неверный логин или пароль", comment: "Invalid Input")
    static let unknownError = NSLocalizedString("Что-то пошло не так, попробуйте войти позже", comment: "Unknown Error")
    static let invalidPasswordLength = NSLocalizedString(
        "Минимальная длина пароля должна быть 4 символа",
        comment: "Invalid Password Length")
}
