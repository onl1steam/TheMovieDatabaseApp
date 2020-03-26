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
    let apiKey = NetworkSettings.apiKey
    
    let emptyAccountIdQuery = "%7Baccount_id%7D"
    
    // MARK: - Tests
    
    func testMakeRequestWithEmptyFields() throws {
        let expectedUrl = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=Foo"
        var endpoint = SearchMovieEndpoint(
            query: "Foo",
            language: nil,
            page: nil,
            includeAdult: nil,
            region: nil,
            year: nil,
            primaryReleaseYear: nil)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
        
    }
    
    func testMakeRequestWithFilledFields() throws {
        let expectedUrl = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=Foo&language=ru&page=1&include_adult=false&region=RU&year=2020&primary_release_year=2020"
        var endpoint = SearchMovieEndpoint(
            query: "Foo",
            language: "ru",
            page: 1,
            includeAdult: false,
            region: "RU",
            year: 2020,
            primaryReleaseYear: 2020)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
    
    func testRequestParameters() throws {
        var endpoint = SearchMovieEndpoint(
            query: "Foo",
            language: "ru",
            page: 1,
            includeAdult: false,
            region: "RU",
            year: 2020,
            primaryReleaseYear: 2020)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        assertGet(request: request)
    }
}
