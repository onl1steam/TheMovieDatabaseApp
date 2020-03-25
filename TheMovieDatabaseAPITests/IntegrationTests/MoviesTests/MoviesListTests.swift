//
//  MoviesListTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 18.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

final class MoviesListTests: XCTestCase {
    
    // MARK: - Properties
    
    var apiClient: APIClient!
    var sessionId: String!
    
    override func setUp() {
        super.setUp()
        let exp = expectation(description: "Авторизация")
        apiClient = NetworkSettings.apiClient
        Authorization.authorize { [weak self] response in
            switch response {
            case .success(let sessionInfo):
                self?.sessionId = sessionInfo.sessionId
            case .failure(let error):
                XCTFail("Ошибка авторизации: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    // MARK: - Tests
    
    func testLoadingFavoriteMovies() {
        let expectation = self.expectation(description: "Получаем список избранных фильмов")
        let favoriteMoviesEndpoint = FavoriteMoviesEndpoint(
            sessionId: sessionId,
            accountId: nil,
            language: nil,
            sortBy: nil,
            page: nil)
        apiClient.request(favoriteMoviesEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertNotEqual(content.totalResults, 0)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchingMovies() {
        let expectation = self.expectation(description: "Получаем список фильмов по введенной строке")
        let searchMoviesEndpoint = SearchMovieEndpoint(
            query: "Звёздные войны",
            language: nil,
            page: nil,
            includeAdult: nil,
            region: nil,
            year: nil,
            primaryReleaseYear: nil)
        apiClient.request(searchMoviesEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertNotEqual(content.totalResults, 0)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
