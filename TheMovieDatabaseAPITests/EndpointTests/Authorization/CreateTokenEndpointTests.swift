//
//  CreateTokenEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class CreateTokenEndpointTests: XCTestCase {
    
    let apiKey = NetworkSettings.apiKey
    
    func testMakeRequest() throws {
        let expectedUrl = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
        var endpoint = CreateTokenEndpoint()
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
}
