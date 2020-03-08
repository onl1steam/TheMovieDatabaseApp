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
    func validateUserInput(login: String?, password: String?) -> Result<User, AuthError>
}

class AuthService: Authorization {
    var authClient: AuthClient
    
    init(authClient: AuthClient = AuthRequest()) {
        self.authClient = authClient
    }
    
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, AuthError>) -> Void) {
        authClient.authorizeWithUser(user: user, completion)
    }
    
    func validateUserInput(login: String?, password: String?) -> Result<User, AuthError> {
        guard let login = login, let password = password else { return .failure(.blankFields) }
        guard login != "", password != "" else { return .failure(.blankFields) }
        let user = User(login: login, password: password)
        return .success(user)
    }
}
