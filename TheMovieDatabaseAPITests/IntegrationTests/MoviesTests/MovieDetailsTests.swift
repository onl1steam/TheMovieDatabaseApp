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
    
    // MARK: - Public Properties
    
    // Id фильма "Джокер"
    let movieId = 475557
    var apiClient: APIClient!
    var sessionId: String!
    
    // MARK: - setUp
    
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
    
    func testLoadingFavoriteMoviesId() {
        let expectation = self.expectation(description: "Получаем информацию о фильме")
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
        wait(for: [expectation], timeout: 5)
    }
    
    func testLoadingFavoriteMoviesTitle() {
        let expectation = self.expectation(description: "Получаем информацию о фильме")
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
        wait(for: [expectation], timeout: 40.0)
    }
}
