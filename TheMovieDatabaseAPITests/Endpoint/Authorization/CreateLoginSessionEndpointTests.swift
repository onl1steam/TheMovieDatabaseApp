//
//  CreateLoginSessionEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class CreateLoginSessionEndpointTests: XCTestCase {
    
    // MARK: - Public Properties
    
    let apiKey = NetworkSettings.apiKey
    
    // MARK: - Tests
    
    func testMakeRequestUrl() throws {
        let expectedUrl = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(apiKey)"
        var endpoint = CreateLoginSessionEndpoint(username: "Foo", password: "Bar", requestToken: "Baz")
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
    
    func testMakeRequestBody() throws {
        var endpoint = CreateLoginSessionEndpoint(username: "Foo", password: "Bar", requestToken: "Baz")
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        
        let body = CreateLoginSessionBody(username: "Foo", password: "Bar", requestToken: "Baz")
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encodedBody = try encoder.encode(body)
        XCTAssertEqual(request.httpBody, encodedBody)
    }
    
    func testRequestParameters() throws {
        var endpoint = CreateLoginSessionEndpoint(username: "Foo", password: "Bar", requestToken: "Baz")
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        assertPost(request: request)
    }
    
    func testParseContent() throws {
        let response = HTTPURLResponse.stub(statusCode: 200)
        guard let data = ResponseStub.stub(name: "CreateRequestToken") else {
            XCTFail("Невалидный JSON файл")
            return
        }
        
        let endpoint = CreateLoginSessionEndpoint(username: "", password: "", requestToken: "")
        let result = try endpoint.content(from: data, response: response)
        
        XCTAssertEqual(result.requestToken, "eeb383164e77813cf5f3fb5eda42ac59048dadd3")
        XCTAssert(result.success)
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data: Data? = nil
        
        let endpoint = CreateLoginSessionEndpoint(username: "", password: "", requestToken: "")
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithEmptyData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = CreateLoginSessionEndpoint(username: "", password: "", requestToken: "")
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
