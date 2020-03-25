//
//  ImageEndpointTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 23.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class ImageEndpointTests: XCTestCase {
    
    // MARK: - Public Propertries
    
    let posterPath = "/Foo.jpg"
    
    // MARK: - Tests
    
    func testMakeRequestWithEmptyFields() throws {
        let expectedUrl = "https://image.tmdb.org/t/p/original\(posterPath)"
        var endpoint = ImageEndpoint(width: nil, imagePath: posterPath)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
    
    func testMakeRequestWithFilledFields() throws {
        let expectedUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
        var endpoint = ImageEndpoint(width: "w500", imagePath: posterPath)
        endpoint.configuration = NetworkSettings.configuration
        let request = try endpoint.makeRequest()
        XCTAssertEqual(request.url?.absoluteString, expectedUrl)
    }
}
