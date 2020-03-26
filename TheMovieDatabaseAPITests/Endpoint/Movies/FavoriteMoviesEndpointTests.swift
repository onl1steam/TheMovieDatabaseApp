//
//  FavoriteMoviesEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class FavoriteMoviesEndpointTests: XCTestCase {
    
    // MARK: - Public Properties
    
    let sessionId = "1"
    let apiKey = NetworkSettings.apiKey
    
    let emptyAccountIdQuery = "%7Baccount_id%7D"
    
    // MARK: - Tests
    
    func testMakeRequestWithEmptyFields() throws {
        let expectedUrl = "https://api.themoviedb.org/3/account/\(emptyAccountIdQuery)/favorite/movies?api_key=\(apiKey)&session_id=\(sessionId)"
        var endpoint =
            FavoriteMoviesEndpoint(sessionId: sessionId, accountId: nil, language: nil, sortBy: nil, page: nil)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
        
    }
    
    func testMakeRequestWithFilledFields() throws {
        let expectedUrl = "https://api.themoviedb.org/3/account/1/favorite/movies?api_key=\(apiKey)&session_id=\(sessionId)&language=ru&sort_by=created_at.asc&page=1"
        var endpoint = FavoriteMoviesEndpoint(
            sessionId: sessionId,
            accountId: 1,
            language: "ru",
            sortBy: "created_at.asc",
            page: 1)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
    
    func testRequestParameters() throws {
        var endpoint = FavoriteMoviesEndpoint(
            sessionId: sessionId,
            accountId: 1,
            language: "ru",
            sortBy: "created_at.asc",
            page: 1)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        assertGet(request: request)
    }
    
    func testParseContent() throws {
        let response = HTTPURLResponse.stub(statusCode: 200)
        guard let data = ResponseStub.stub(name: "FavoriteMovies") else {
            XCTFail("Невалидный JSON файл")
            return
        }
        
        let endpoint = FavoriteMoviesEndpoint(sessionId: "", accountId: nil, language: nil, sortBy: nil, page: nil)
        let result = try endpoint.content(from: data, response: response)
        
        XCTAssertEqual(result.totalResults, 2)
        XCTAssertEqual(result.page, 1)
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data: Data? = nil
        
        let endpoint = FavoriteMoviesEndpoint(sessionId: "", accountId: nil, language: nil, sortBy: nil, page: nil)
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithEmptyData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = FavoriteMoviesEndpoint(sessionId: "", accountId: nil, language: nil, sortBy: nil, page: nil)
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
