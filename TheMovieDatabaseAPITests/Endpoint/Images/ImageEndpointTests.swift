//
//  ImageEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

final class ImageEndpointTests: XCTestCase {
    
    // MARK: - Public Propertries
    
    let posterPath = "/Foo.jpg"
    
    // MARK: - Tests
    
    func testMakeRequestWithEmptyFields() throws {
        var endpoint = ImageEndpoint(width: nil, imagePath: posterPath)
        endpoint.configuration = NetworkSettings.configuration

        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.url?.absoluteString, "https://image.tmdb.org/t/p/original\(posterPath)")
    }
    
    func testMakeRequestWithFilledFields() throws {
        var endpoint = ImageEndpoint(width: "w500", imagePath: posterPath)
        endpoint.configuration = NetworkSettings.configuration
        
        let request = try endpoint.makeRequest()
        
        XCTAssertEqual(request.url?.absoluteString, "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    func testParseContent() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data = Data()
        
        let endpoint = ImageEndpoint(width: "", imagePath: "")
        
        XCTAssertNoThrow(try endpoint.content(from: data, response: response), "Парсинг данных")
    }
    
    func testParseContentWithError() {
        let response = HTTPURLResponse.stub(statusCode: 404)
        let data = Data()
        
        let endpoint = ImageEndpoint(width: "", imagePath: "")
        
        XCTAssertThrowsError(
            try endpoint.content(from: data, response: response)) { error in
                
                XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
        }
    }
    
    func testParseContentWithBlankData() {
        let response = HTTPURLResponse.stub(statusCode: 200)
        let data: Data? = nil
        
        let endpoint = ImageEndpoint(width: "", imagePath: "")
        
        XCTAssertThrowsError(
            try endpoint.content(from: data, response: response),
            "Парсинг данных с ошибкой") { error in
                
                XCTAssertEqual(error.localizedDescription, NetworkError.blankData.localizedDescription)
        }
    }
    
    func testRequestParameters() throws {
        var endpoint = ImageEndpoint(width: "w500", imagePath: posterPath)
        endpoint.configuration = NetworkSettings.configuration
        
        let request = try endpoint.makeRequest()
        
        assertGet(request: request)
    }
}
