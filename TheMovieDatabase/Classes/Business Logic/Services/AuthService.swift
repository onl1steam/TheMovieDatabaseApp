//
//  AuthService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

protocol Authorization {
    func authorizeWithUser(login: String, password: String, _ completion: @escaping (Result<String, Error>) -> Void)
}

class AuthService: Authorization {
    
    var authClient: AuthClient
    
    init(authClient: AuthClient = AuthRequest()) {
        self.authClient = authClient
    }
    
    func authorizeWithUser(login: String, password: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        authClient.authorizeWithUser(login: login, password: password, completion)
    }
}
