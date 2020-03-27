//
//  SearchMoviesEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class SearchMoviesEndpointTests: XCTestCase {
    
    // MARK: - Public Propetries
    
    let sessionId = "1"
    let emptyAccountIdQuery = "%7Baccount_id%7D"
    
    // MARK: - Tests
    
    func testMakeRequestWithEmptyFields() throws {
        let endpoint = SearchMovieEndpoint(
            query: "Foo",
            language: nil,
            page: nil,
            includeAdult: nil,
            region: nil,
            year: nil,
            primaryReleaseYear: nil)
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.url?.absoluteString, "3/search/movie?query=Foo")
        
    }
    
    func testMakeRequestWithFilledFields() throws {
        let endpoint = SearchMovieEndpoint(
            query: "Foo",
            language: "ru",
            page: 1,
            includeAdult: false,
            region: "RU",
            year: 2020,
            primaryReleaseYear: 2020)
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(
            request.url?.absoluteString,
            "3/search/movie?query=Foo&language=ru&page=1&include_adult=false" +
            "&region=RU&year=2020&primary_release_year=2020")
    }
    
    func testRequestParameters() throws {
        let endpoint = SearchMovieEndpoint(
            query: "Foo",
            language: "ru",
            page: 1,
            includeAdult: false,
            region: "RU",
            year: 2020,
            primaryReleaseYear: 2020)
        let request = try endpoint.makeRequest()
        assertGet(request: request)
    }
    
    func testParseContent() throws {
        let response = HTTPURLResponse.stub(statusCode: 200)
        guard let data = ResponseStub.stub(name: "SearchMovies") else {
            XCTFail("Невалидный JSON файл")
            return
        }
        
        let endpoint = SearchMovieEndpoint(
            query: "",
            language: nil,
            page: nil,
            includeAdult: nil,
            region: nil,
            year: nil,
            primaryReleaseYear: nil)
        let result = try endpoint.content(from: data, response: response)
        
        XCTAssertEqual(result.totalResults, 2)
        XCTAssertEqual(result.page, 1)
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data: Data? = nil
        
        let endpoint = SearchMovieEndpoint(
            query: "",
            language: nil,
            page: nil,
            includeAdult: nil,
            region: nil,
            year: nil,
            primaryReleaseYear: nil)
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithEmptyData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = SearchMovieEndpoint(
            query: "",
            language: nil,
            page: nil,
            includeAdult: nil,
            region: nil,
            year: nil,
            primaryReleaseYear: nil)
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
