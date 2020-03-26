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
}
