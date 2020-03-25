//
//  SessionServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class SessionServiceTests: XCTestCase {
    
    var authService: Authorization!
    var sessionService: Session!
    
    override func setUp() {
        super.setUp()
        authService = ServiceLayer.shared.authService
        sessionService = ServiceLayer.shared.sessionService
        
        let exp = expectation(description: "Авторизация")
        createSession { [weak self] response in
            switch response {
            case .success(let sessionId):
                self?.sessionService.setupSessionId(sessionId: sessionId)
            case .failure(let error):
                XCTFail("Ошибка авторизации: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testLoadingAccountInfo() {
        sessionService.accountInfo { response in
            switch response {
            case .success(let accountResponse):
                XCTAssertEqual(accountResponse.username, "onl1steam")
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func testLoadingFavoriteMoviesWithEmptyData() {
        sessionService.favoriteMovies(language: nil, sortBy: nil, page: nil) { response in
            switch response {
            case .success(let moviesResponse):
                XCTAssert(moviesResponse.totalResults > 0)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func testLoadingFavoriteMoviesWithFilledData() {
        sessionService.favoriteMovies(language: "ru", sortBy: "created_at.asc", page: 1) { response in
            switch response {
            case .success(let moviesResponse):
                XCTAssert(moviesResponse.totalResults > 0)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func testDeletingSession() {
        sessionService.deleteSession { response in
            switch response {
            case .success(let isSucceed):
                XCTAssert(isSucceed)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func createSession(_ completion: @escaping (Result<String, Error>) -> Void) {
        let user = User(login: "onl1steam", password: "Onl1sTeam")
        authService.authorizeWithUser(user: user, completion)
    }
}
