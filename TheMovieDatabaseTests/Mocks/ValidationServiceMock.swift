//
//  ValidationServiceMock.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase

final class ValidationServiceMock: Validation {
    
    func validateUserInput(user: User, _ completion: @escaping (Result<User, AuthError>) -> Void) {
        let user = User(login: "Foo", password: "Foo")
        completion(.success(user))
    }
}
