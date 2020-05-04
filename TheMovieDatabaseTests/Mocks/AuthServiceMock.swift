//
//  AuthServiceMock.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase

final class AuthServiceMock: Authorization {
    
    func authorizeWithUser(user: User, _ completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("Foo"))
    }
}
