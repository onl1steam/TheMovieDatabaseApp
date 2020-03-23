//
//  DeleteSessionEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class DeleteSessionEndpointTests: XCTestCase {
    
    let apiKey = NetworkSettings.apiKey
    
    func testMakeRequestUrl() throws {
        let expectedUrl = "https://api.themoviedb.org/3/authentication/session?api_key=\(apiKey)"
        var endpoint = DeleteSessionEndpoint(sessionId: "Foo")
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
    
    func testMakeRequestBody() throws {
        var endpoint = DeleteSessionEndpoint(sessionId: "Foo")
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        
        let body = DeleteSessionBody(sessionId: "Foo")
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encodedBody = try encoder.encode(body)
        XCTAssertEqual(request.httpBody, encodedBody)
    }
}
