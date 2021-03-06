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
    
    // MARK: - Public Properties
    
    let sessionId = "1"
    
    // MARK: - Tests

    func testMakeRequest() throws {
        let endpoint = AccountDetailsEndpoint(sessionId: sessionId)
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.url?.absoluteString, "3/account?session_id=\(sessionId)")
    }
    
    func testRequestParameters() throws {
        let endpoint = AccountDetailsEndpoint(sessionId: sessionId)
        
        let request = try endpoint.makeRequest()
        
        assertGet(request: request)
    }
    
    func testParseContent() throws {
        let response = HTTPURLResponse.stub(statusCode: 200)
        guard let data = ResponseStub.stub(name: "AccountDetails") else {
            XCTFail("Невалидный JSON файл")
            return
        }
        
        let endpoint = AccountDetailsEndpoint(sessionId: "")
        let result = try endpoint.content(from: data, response: response)
        
        XCTAssertEqual(result.id, 9107546)
        XCTAssertEqual(result.username, "onl1steam")
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data: Data? = nil
        
        let endpoint = AccountDetailsEndpoint(sessionId: "")
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithEmptyData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = AccountDetailsEndpoint(sessionId: "")
        
        XCTAssertThrowsError(try endpoint.content(from: data, response: response)) { error in
            XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
