//
//  SessionServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
@testable import TheMovieDatabaseAPI
import XCTest

final class SessionServiceTests: XCTestCase {
    
    // MARK: - Public Properties
    
    var sessionService: Session!
    var apiClient: MockAPIClient!
    
    var accountResponse: AccountResponse!
    var moviesResponse: MoviesResponse!
    var deleteSessionResponse: DeleteSessionResponse!
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        
        let gravatar = AccountResponse.Gravatar(hash: "test")
        let avatar = AccountResponse.Avatar(gravatar: gravatar)
        accountResponse = AccountResponse(
            avatar: avatar,
            id: 1,
            iso6391: "ru",
            iso31661: "ru",
            name: "Foo",
            includeAdult: true,
            username: "Bar")
        
        moviesResponse = MoviesResponse(page: 1, results: [], totalPages: 1, totalResults: 5)
        deleteSessionResponse = DeleteSessionResponse(success: true)
        
        apiClient = MockAPIClient()
        sessionService = SessionService(apiClient: apiClient)
        sessionService.setupSessionId(sessionId: "Foo")
    }
    
    // MARK: - Tests
    
    func testLoadingAccountInfo() {
        let exp = expectation(description: "Загрузка профиля")
        
        sessionService.accountInfo { response in
            switch response {
            case .success(let accountResponse):
                XCTAssertEqual(accountResponse.username, "Bar")
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        _ = apiClient.fulfil(AccountDetailsEndpoint.self, with: accountResponse)
        wait(for: [exp], timeout: 5)
    }
    
    func testLoadingFavoriteMoviesWithEmptyData() {
        let exp = expectation(description: "Загрузка изображений")
        
        sessionService.favoriteMovies(language: nil, sortBy: nil, page: nil) { response in
            switch response {
            case .success(let moviesResponse):
                XCTAssert(moviesResponse.totalResults > 0)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        _ = apiClient.fulfil(FavoriteMoviesEndpoint.self, with: moviesResponse)
        wait(for: [exp], timeout: 5)
    }
    
    func testLoadingFavoriteMoviesWithFilledData() {
        let exp = expectation(description: "Загрузка изображений")
        
        sessionService.favoriteMovies(language: "ru", sortBy: "created_at.asc", page: 1) { response in
            switch response {
            case .success(let moviesResponse):
                XCTAssert(moviesResponse.totalResults > 0)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        _ = apiClient.fulfil(FavoriteMoviesEndpoint.self, with: moviesResponse)
        wait(for: [exp], timeout: 5)
    }
    
    func testDeletingSession() {
        let exp = expectation(description: "Загрузка изображений")
        
        sessionService.deleteSession { response in
            switch response {
            case .success(let isSucceed):
                XCTAssert(isSucceed)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        _ = apiClient.fulfil(DeleteSessionEndpoint.self, with: deleteSessionResponse)
        wait(for: [exp], timeout: 5)
    }
}
