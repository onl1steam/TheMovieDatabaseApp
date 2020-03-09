//
//  AuthService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

protocol Authorization {
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, AuthError>) -> Void)
    func validateUserInput(login: String?, password: String?, _ completion: @escaping (Result<User, AuthError>) -> Void)
}

class AuthService: Authorization {
    var authClient: AuthClient
    
    init(authClient: AuthClient = AuthRequest()) {
        self.authClient = authClient
    }
    
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, AuthError>) -> Void) {
        authClient.authorizeWithUser(user: user, completion)
    }
    
    func validateUserInput(
        login: String?,
        password: String?,
        _ completion: @escaping (Result<User, AuthError>) -> Void) {
        guard let login = login,
            let password = password,
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
