//
//  AvatarEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class AvatarEndpointTests: XCTestCase {
    
    // MARK: - Public Properties
    
    let avatarHash = "Foo"
    
    // MARK: - Tests
    
    func testMakeRequest() throws {
        let expectedUrl = "https://www.gravatar.com/avatar/\(avatarHash)"
        var endpoint = AvatarEndpoint(imagePath: avatarHash)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
    
    func testRequestParameters() throws {
        var endpoint = AvatarEndpoint(imagePath: avatarHash)
        endpoint.configuration = NetworkSettings.configuration
        
        let request = try endpoint.makeRequest()
        
        assertGet(request: request)
    }
    
    func testParseContent() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data = Data()
        
        let endpoint = AvatarEndpoint(imagePath: "")
        
        XCTAssertNoThrow(try endpoint.content(from: data, response: response), "Парсинг данных")
    }
    
    func testParseContentWithError() throws {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data = Data()
        
        let endpoint = AvatarEndpoint(imagePath: "")
        
        XCTAssertThrowsError(
            try endpoint.content(from: data, response: response)) { error in
                
                XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithBlankData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = AvatarEndpoint(imagePath: "")
        
        XCTAssertThrowsError(
            try endpoint.content(from: data, response: response),
            "Парсинг данных с ошибкой") { error in
                
                XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
}
