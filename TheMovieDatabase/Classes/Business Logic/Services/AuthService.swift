//
//  AuthService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

/// Авторизация пользователя в базе данных фильмов.
protocol Authorization {
    
    /// Авторизирует пользователя в системе с заданными данными.
    ///
    /// - Parameters:
    ///   - user: Данные пользователя.
    ///   - completion: Замыкание, вызывающееся после отработки метода. Возвращает id сессии в случае успеха
    ///   или ошибку в случае неудачи.
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, Error>) -> Void)
    
    /// Валидирует введенные пользовательские данные.
    ///
    /// - Parameters:
    ///   - user: Данные пользователя.
    ///   - completion: Замыкание, вызывающееся после отработки метода. Возвращает введенные пользовательские данные в случае успеха
    ///   или ошибку типа AuthError в случае неудачи.
    func validateUserInput(user: User, _ completion: @escaping (Result<User, AuthError>) -> Void)
}

class AuthService: Authorization {
    
    // MARK: - Public properties
    
    let apiClient: APIClient
    let baseURL = URL(string: "https://api.themoviedb.org/")!
    let apiKey = "591efe0e25fd45c1579562958b2364db"
    var requestToken = ""
    
    // MARK: - Initializers
    
    init(apiClient: APIClient = APIRequest()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Authorization
    
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, Error>) -> Void) {
        let createTokenEndpoint = CreateTokenEndpoint(baseURL: baseURL, apiKey: apiKey)
        apiClient.request(createTokenEndpoint) { response in
            switch response {
            case .success(let content):
                self.requestToken = content
                self.createLoginSession(user: user, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
        
    private func createLoginSession(user: User, _ completion: @escaping (Result<String, Error>) -> Void) {
        let createLoginSessionEndpoint = CreateLoginSessionEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
            username: user.login!,
            password: user.password!,
            requestToken: requestToken)
        
        apiClient.request(createLoginSessionEndpoint) { response in
            switch response {
            case .success:
                self.createSession(user: user, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createSession(user: User, _ completion: @escaping (Result<String, Error>) -> Void) {
        let createSession = CreateSessionEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
            requestToken: requestToken)
        
        apiClient.request(createSession) { response in
            switch response {
            case .success(let sessionId):
                completion(.success(sessionId))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
