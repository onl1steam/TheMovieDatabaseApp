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
    
    // MARK: - Public Properties
    
    let apiKey = NetworkSettings.apiKey
    
    // MARK: - Tests
    
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
    
    func testRequestParameters() throws {
        var endpoint = DeleteSessionEndpoint(sessionId: "Foo")
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        assertDelete(request: request)
    }
    
    func testParseContent() throws {
        let response = HTTPURLResponse.stub(statusCode: 200)
        guard let data = ResponseStub.stub(name: "CreateSession") else {
            XCTFail("Невалидный JSON файл")
            return
        }
        
        let endpoint = DeleteSessionEndpoint(sessionId: "")
        let result = try endpoint.content(from: data, response: response)
        
        XCTAssert(result.success)
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data: Data? = nil
        
        let endpoint = DeleteSessionEndpoint(sessionId: "")
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithEmptyData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = DeleteSessionEndpoint(sessionId: "")
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
