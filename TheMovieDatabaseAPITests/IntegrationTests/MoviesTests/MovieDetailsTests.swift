//
//  MovieDetailsTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 18.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

final class MovieDetailsTests: XCTestCase {
    
    // MARK: - Properties
    
    // Id фильма "Джокер"
    let movieId = 475557
    
    let baseURL = NetworkSettings.baseURL
    let apiKey = NetworkSettings.apiKey
    let apiClient = NetworkSettings.apiClient
    
    // MARK: - Tests
    
    func testLoadingFavoriteMoviesId() {
        let expectation = self.expectation(description: "Получаем информацию о фильме")
        createSession(expectation: expectation, getFavoriteMoviesIdTest)
        waitForExpectations(timeout: 40, handler: nil)
    }
    
    func testLoadingFavoriteMoviesTitle() {
        let expectation = self.expectation(description: "Получаем информацию о фильме")
        createSession(expectation: expectation, loadFavoriteMoviesTitleTest)
        waitForExpectations(timeout: 40, handler: nil)
    }
    
     // MARK: - Methods
    
    func getFavoriteMoviesIdTest(expectation: XCTestExpectation, sessionId: String) {
        let movieDetailsEndpoint = MovieDetailsEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
            movieId: movieId,
            language: "ru")
        apiClient.request(movieDetailsEndpoint) { [weak self] response in
            guard let self = self else { return }
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertEqual(self.movieId, content.id)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func loadFavoriteMoviesTitleTest(expectation: XCTestExpectation, sessionId: String) {
        let movieDetailsEndpoint = MovieDetailsEndpoint(
            baseURL: baseURL,
            apiKey: apiKey,
            movieId: movieId,
            language: "ru")
        apiClient.request(movieDetailsEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertEqual("Джокер", content.title)
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
