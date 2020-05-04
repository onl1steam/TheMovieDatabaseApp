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
    
    let baseURL = NetworkSettings.baseURL
    let apiKey = NetworkSettings.apiKey
    let apiClient = NetworkSettings.apiClient
    
    // MARK: - Tests
    
    func testLoadingFavoriteMovies() {
        let expectation = self.expectation(description: "Получаем список избранных фильмов")
        createSession(expectation: expectation, loadFavoriteMoviesTest)
        waitForExpectations(timeout: 40, handler: nil)
    }
    
    func testSearchingMovies() {
        let expectation = self.expectation(description: "Получаем список фильмов по введенной строке")
        createSession(expectation: expectation, searchMoviesTest)
        waitForExpectations(timeout: 40, handler: nil)
    }
    
     // MARK: - Methods
    
    func loadFavoriteMoviesTest(expectation: XCTestExpectation, sessionId: String) {
        let favoriteMoviesEndpoint = FavoriteMoviesEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
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
    }
    
    func searchMoviesTest(expectation: XCTestExpectation, sessionId: String) {
        let searchMoviesEndpoint = SearchMovieEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
            query: "Звёздные войны",
            language: nil,
            page: nil)
        apiClient.request(searchMoviesEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertNotEqual(content.totalResults, 0)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func createSession(
        expectation: XCTestExpectation,
        _ completion: @escaping (_ expectation: XCTestExpectation, _ sessionId: String) -> Void) {
        
        let authorization: AuthorizationType = Authorization()
        authorization.authorize { response in
            switch response {
            case .success(let content):
                completion(expectation, content.sessionId)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
