//
//  ValidationService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

protocol Validation {
    
    /// Валидирует введенные пользовательские данные.
    ///
    /// - Parameters:
    ///   - user: Данные пользователя.
    ///   - completion: Замыкание, вызывающееся после отработки метода. Возвращает введенные пользовательские данные в случае успеха
    ///   или ошибку типа AuthError в случае неудачи.
    func validateUserInput(user: User, _ completion: @escaping (Result<User, AuthError>) -> Void)
}

final class ValidationService: Validation {
    
    func validateUserInput(
        user: User,
        _ completion: @escaping (Result<User, AuthError>) -> Void) {
        guard let login = user.login,
            let password = user.password,
            login != "",
            password != "" else {
                completion(.failure(.blankFields))
                return
        }
        guard password.count >= 4 else {
            completion(.failure(.invalidPasswordLength))
            return
        }
        let user = User(login: login, password: password)
        completion(.success(user))
    }
}
