//
//  AuthService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Авторизация пользователя в базе данных фильмов.
protocol Authorization {
    
    /// Авторизирует пользователя в системе с заданными данными.
    ///
    /// - Parameters:
    ///   - user: Данные пользователя.
    ///   - completion: Замыкание, вызывающееся после отработки метода. Возвращает id сессии в случае успеха
    ///   или ошибку типа AuthError в случае неудачи.
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, AuthError>) -> Void)
    
    /// Валидирует введенные пользовательские данные.
    ///
    /// - Parameters:
    ///   - user: Данные пользователя.
    ///   - completion: Замыкание, вызывающееся после отработки метода. Возвращает введенные пользовательские данные в случае успеха
    ///   или ошибку типа AuthError в случае неудачи.
    func validateUserInput(user: User, _ completion: @escaping (Result<User, AuthError>) -> Void)
}

class AuthService: Authorization {
    
    // MARK: - Public Properties
    
    var authClient: AuthClient
    
    // MARK: - Initializers
    
    init(authClient: AuthClient = AuthRequest()) {
        self.authClient = authClient
    }
    
    // MARK: - Authorization
    
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, AuthError>) -> Void) {
        authClient.authorizeWithUser(user, completion)
    }
    
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
