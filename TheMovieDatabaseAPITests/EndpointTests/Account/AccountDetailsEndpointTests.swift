//
//  AccountDetailsEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class AccountDetailsEndpointTests: XCTestCase {
    
    let sessionId = "1"
    let apiKey = NetworkSettings.apiKey

    func testMakeRequest() throws {
        let expectedUrl = "https://api.themoviedb.org/3/account?api_key=\(apiKey)&session_id=\(sessionId)"
        var endpoint = AccountDetailsEndpoint(sessionId: sessionId)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
}