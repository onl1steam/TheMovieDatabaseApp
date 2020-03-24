//
//  AuthServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

class AuthServiceTests: XCTestCase {
    
    var authService: Authorization!
    
    override func setUp() {
        super.setUp()
        authService = ServiceLayer.shared.authService
    }
    
    func testAuthorizationWithLogin() {
        let exp = expectation(description: "Авторизация пользователя")
        let user = User(login: "onl1steam", password: "Onl1sTeam")
        authService.authorizeWithUser(user: user) { response in
            switch response {
            case .success(let sessionId):
                XCTAssertNotEqual(sessionId, "")
            case .failure(let error):
                XCTFail("Ошибка авторизации: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
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
        wait(for: [exp], timeout: 5)
    }
}
