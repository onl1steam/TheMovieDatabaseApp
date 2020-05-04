//
//  AuthorizationModel.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

class AuthorizationModel: XCTestCase {
    
    static let baseURL = NetworkConfiguration.baseURL
    static let apiKey = NetworkConfiguration.apiKey
    static let authService = ServiceLayer.shared.authService
    
    static var sessionId: String?
    static var requestToken: String?
    
    static func authorize(_ completion: @escaping (Result<String, Error>) -> Void) {
        if let sessionId = AuthorizationModel.sessionId {
            completion(.success(sessionId))
        } else {
            createSession(completion)
        }
    }
    
    private static func createSession(_ completion: @escaping (Result<String, Error>) -> Void) {
        let user = User(login: "onl1steam", password: "Onl1sTeam")
        authService.authorizeWithUser(user: user, completion)
    }
}
