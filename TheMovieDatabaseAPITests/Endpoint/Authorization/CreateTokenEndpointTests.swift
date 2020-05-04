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
    
    // MARK: - Tests
    
    func testMakeRequest() throws {
        let endpoint = CreateTokenEndpoint()
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.url?.absoluteString, "3/authentication/token/new")
    }
    
    func testRequestParameters() throws {
        let endpoint = CreateTokenEndpoint()
        
        let request = try endpoint.makeRequest()
        
        assertGet(request: request)
    }
    
    func testParseContent() throws {
        let response = HTTPURLResponse.stub(statusCode: 200)
        guard let data = ResponseStub.stub(name: "CreateRequestToken") else {
            XCTFail("Невалидный JSON файл")
            return
        }
        
        let endpoint = CreateTokenEndpoint()
        let result = try endpoint.content(from: data, response: response)
        
        XCTAssertEqual(result.requestToken, "eeb383164e77813cf5f3fb5eda42ac59048dadd3")
        XCTAssert(result.success)
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data: Data? = nil
        
        let endpoint = CreateTokenEndpoint()
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithEmptyData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = CreateTokenEndpoint()
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
