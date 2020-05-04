//
//  AuthServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
@testable import TheMovieDatabaseAPI
import XCTest

final class AuthServiceTests: XCTestCase {
    
    // MARK: - Public Properties
    
    var authService: Authorization!
    var apiClient: MockAPIClient!
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        authService = AuthService(apiClient: apiClient)
    }
    
    // MARK: - Tests
    
    func testAuthorizationWithLogin() {
        let exp = expectation(description: "Авторизация пользователя")
        let user = User(login: "onl1steam", password: "Onl1sTeam")
        
        authService.authorizeWithUser(user: user) { response in
            switch response {
            case .success(let sessionId):
                XCTAssertEqual(sessionId, "Foo")
            case .failure(let error):
                XCTFail("Ошибка авторизации: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        let authResponse = AuthResponse(success: true, expiresAt: "12", requestToken: "Foo")
        let sessionResponse = SessionResponse(sessionId: "Foo", success: true)
        _ = apiClient.fulfil(CreateTokenEndpoint.self, with: authResponse)
        _ = apiClient.fulfil(CreateLoginSessionEndpoint.self, with: authResponse)
        _ = apiClient.fulfil(CreateSessionEndpoint.self, with: sessionResponse)
        
        wait(for: [exp], timeout: 5)
    }
    
    func testAuthorizationWithInvalidLogin() {
        let exp = expectation(description: "Авторизация пользователя")
        let user = User(login: "test", password: "test")
        
        authService.authorizeWithUser(user: user) { response in
            switch response {
            case .success:
                XCTFail("Авторизация не должна была произойти")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Произошла ошибка при авторизации.")
            }
            exp.fulfill()
        }
        
        let authResponse = AuthResponse(success: true, expiresAt: "12", requestToken: "Foo")
        let sessionResponse = SessionResponse(sessionId: "Foo", success: true)
        _ = apiClient.fulfil(CreateTokenEndpoint.self, with: authResponse)
        _ = apiClient.fail(CreateLoginSessionEndpoint.self, with: NetworkError.unauthorized)
        _ = apiClient.fulfil(CreateSessionEndpoint.self, with: sessionResponse)
        
        wait(for: [exp], timeout: 5)
    }
}
