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
        createSession(expectation: expectation, loadFavoriteMoviesIdTest)
        wait(for: [expectation], timeout: 40.0)
    }
    
    func testLoadingFavoriteMoviesTitle() {
        let expectation = self.expectation(description: "Получаем информацию о фильме")
        createSession(expectation: expectation, loadFavoriteMoviesTitleTest)
        wait(for: [expectation], timeout: 40.0)
    }
    
     // MARK: - Methods
    
    func loadFavoriteMoviesIdTest(expectation: XCTestExpectation, sessionId: String) {
        let movieDetailsEndpoint = MovieDetailsEndpoint(
            movieId: movieId,
            language: nil)
        apiClient.request(movieDetailsEndpoint) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let content):
                XCTAssertEqual(self.movieId, content.id)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
    }
    
    func loadFavoriteMoviesTitleTest(expectation: XCTestExpectation, sessionId: String) {
        let movieDetailsEndpoint = MovieDetailsEndpoint(
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
