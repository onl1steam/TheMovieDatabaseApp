//
//  LocalizationStrings.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

enum LocalizedStrings {
    // Строки экрана избранных фильмов
    static let favoriteLabel = NSLocalizedString("Избранное", comment: "Favorite Label")
    static let blankListLabel = NSLocalizedString("Вы не добавили ни одного фильма", comment: "Movies Label")
    static let searchFilmsButtonText = NSLocalizedString("Найти любимые фильмы", comment: "Search Films Button Text")
    // Строки экрана фильмов
    static let moviesLabel = NSLocalizedString("Найдем любой фильм на ваш вкуc", comment: "Movies Label")
    static let searchBarPlaceholder = NSLocalizedString("Поиск фильмов", comment: "SearchBar Placeholder")
    // Строки экрана профиля
    static let logoutButtonText = NSLocalizedString("Выйти", comment: "Logout Button Text")
    // Строки экрана авторизации
    static let authWelcome = NSLocalizedString("Добро пожаловать!", comment: "Auth Welcome")
    static let authInfo = NSLocalizedString("Укажите логин и пароль, которые вы использовали для входа",
                                            comment: "Auth Info")
    static let loginPlaceholder = NSLocalizedString("Логин", comment: "Login Placeholder")
    static let passwordPlaceholder = NSLocalizedString("Пароль", comment: "Password Placeholder")
    static let loginButtonText = NSLocalizedString("Войти", comment: "Login Button Text")
    // Строки из TabBar
    static let moviesTabBar = NSLocalizedString("Фильмы", comment: "Movies Tab Bar")
    static let accountTabBar = NSLocalizedString("Профиль", comment: "Account Tab Bar")
    static let favoriteTabBar = NSLocalizedString("Избранное", comment: "Favorite Tab Bar")
    // Строки ошибок
    static let blankFields = NSLocalizedString("Не заполнены все поля", comment: "Blank Fields")
    static let invalidInput = NSLocalizedString("Неверный логин или пароль", comment: "Invalid Input")
    static let unknownError = NSLocalizedString("Что-то пошло не так, попробуйте войти позже", comment: "Unknown Error")
}
