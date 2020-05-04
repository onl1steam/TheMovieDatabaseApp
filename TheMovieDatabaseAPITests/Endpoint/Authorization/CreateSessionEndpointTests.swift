//
//  CreateSessionEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class CreateSessionEndpointTests: XCTestCase {
    
    // MARK: - Tests
    
    func testMakeRequestUrl() throws {
        let endpoint = CreateSessionEndpoint(requestToken: "Foo")
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.url?.absoluteString, "3/authentication/session/new")
    }
    
    func testMakeRequestBody() throws {
        let endpoint = CreateSessionEndpoint(requestToken: "Foo")
        let body = CreateSessionBody(requestToken: "Foo")
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encodedBody = try encoder.encode(body)
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.httpBody, encodedBody)
    }
    
    func testRequestParameters() throws {
        let endpoint = CreateSessionEndpoint(requestToken: "Foo")
        let request = try endpoint.makeRequest()
        assertPost(request: request)
    }
    
    func testParseContent() throws {
        let response = HTTPURLResponse.stub(statusCode: 200)
        guard let data = ResponseStub.stub(name: "CreateSession") else {
            XCTFail("Невалидный JSON файл")
            return
        }
        
        let endpoint = CreateSessionEndpoint(requestToken: "Foo")
        let result = try endpoint.content(from: data, response: response)
        
        XCTAssertEqual(result.sessionId, "3e5ab2150c79283bc08f08a9e15bd60d642d0a3d")
        XCTAssert(result.success)
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data: Data? = nil
        
        let endpoint = CreateSessionEndpoint(requestToken: "Foo")
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithEmptyData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = CreateSessionEndpoint(requestToken: "Foo")
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
