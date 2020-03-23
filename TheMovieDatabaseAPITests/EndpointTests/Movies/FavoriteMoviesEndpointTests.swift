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
    
    let sessionId = "1"
    let apiKey = NetworkSettings.apiKey
    
    let emptyAccountIdQuery = "%7Baccount_id%7D"
    
    func testMakeRequestWithEmptyFields() throws {
        let expectedUrl = "https://api.themoviedb.org/3/account/\(emptyAccountIdQuery)/favorite/movies?api_key=\(apiKey)&session_id=\(sessionId)"
        var endpoint =
            FavoriteMoviesEndpoint(sessionId: sessionId, accountId: nil, language: nil, sortBy: nil, page: nil)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url!.absoluteString, expectedUrl)
        
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
        XCTAssertEqual(request.url!.absoluteString, expectedUrl)
    }
}
