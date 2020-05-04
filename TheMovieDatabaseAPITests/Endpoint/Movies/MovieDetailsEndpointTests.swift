//
//  MovieDetailsEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class MovieDetailsEndpointTests: XCTestCase {
    
    // MARK: - Public Properties
    
    let sessionId = "1"
    let emptyAccountIdQuery = "%7Baccount_id%7D"
    
    // MARK: - Tests
    
    func testMakeRequestWithEmptyFields() throws {
        let endpoint = MovieDetailsEndpoint(movieId: 1, language: nil)
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.url?.absoluteString, "3/movie/1?")
    }
    
    func testMakeRequestWithFilledFields() throws {
        let endpoint = MovieDetailsEndpoint(movieId: 1, language: "ru")
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.url?.absoluteString, "3/movie/1?language=ru")
    }
    
    func testRequestParameters() throws {
        let endpoint = MovieDetailsEndpoint(movieId: 1, language: "ru")
        let request = try endpoint.makeRequest()
        assertGet(request: request)
    }
    
    func testParseContent() throws {
        let response = HTTPURLResponse.stub(statusCode: 200)
        guard let data = ResponseStub.stub(name: "MovieDetails") else {
            XCTFail("Невалидный JSON файл")
            return
        }
        
        let endpoint = MovieDetailsEndpoint(movieId: 1, language: nil)
        let result = try endpoint.content(from: data, response: response)
        
        XCTAssertEqual(result.id, 1892)
        XCTAssertEqual(result.title, "Звёздные войны: Эпизод VI – Возвращение Джедая")
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data: Data? = nil
        
        let endpoint = MovieDetailsEndpoint(movieId: 1, language: nil)
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithEmptyData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = MovieDetailsEndpoint(movieId: 1, language: nil)
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
