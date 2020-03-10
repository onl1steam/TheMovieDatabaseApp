//
//  AuthScreenStrings.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

enum AuthScreenStrings {
    static let authWelcome = NSLocalizedString("Добро пожаловать!", comment: "Auth Welcome")
    static let authInfo = NSLocalizedString("Укажите логин и пароль, которые вы использовали для входа",
                                            comment: "Auth Info")
    static let loginPlaceholder = NSLocalizedString("Логин", comment: "Login Placeholder")
    static let passwordPlaceholder = NSLocalizedString("Пароль", comment: "Password Placeholder")
    static let loginButtonText = NSLocalizedString("Войти", comment: "Login Button Text")
}
