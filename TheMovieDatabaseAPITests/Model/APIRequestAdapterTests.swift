//
//  APIRequestAdapterTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 28.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import XCTest

import XCTest
@testable import Alamofire
@testable import TheMovieDatabaseAPI

class APIRequestAdapterTests: XCTestCase {
    
    var requestAdapter: APIRequestAdapter!
    var session: Session!

    override func setUp() {
        super.setUp()
        session = Session()
        let defaultUrl = URL(string: "https://api.themoviedb.org")!
        let imageUrl = URL(string: "http://image.tmdb.org")!
        let avatarUrl = URL(string: "http://gravatar.com")!
        let cofiguration = Configuration(
            baseURL: defaultUrl,
            basePosterURL: imageUrl,
            baseAvatarURL: avatarUrl,
            apiKey: "Foo")
        requestAdapter = APIRequestAdapter(configuration: cofiguration)
    }

    func testAdaptDefaultRequest() throws {
        let endpoint = AccountDetailsEndpoint(sessionId: "Bar")
        let request = try endpoint.makeRequest()
        
        requestAdapter.adapt(request, for: session) { response in
            switch response {
            case .success(let request):
                XCTAssertEqual(
                    request.url?.absoluteString,
                    "https://api.themoviedb.org/3/account?session_id=Bar&api_key=Foo")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testAdaptImageRequest() throws {
        let endpoint = ImageEndpoint(width: nil, imagePath: "Foo")
        let request = try endpoint.makeRequest()
        
        requestAdapter.adapt(request, for: session) { response in
            switch response {
            case .success(let request):
                XCTAssertEqual(
                    request.url?.absoluteString,
                    "http://image.tmdb.org/t/p/original/Foo")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testAdaptImageWithWidthRequest() throws {
        let endpoint = ImageEndpoint(width: "w500", imagePath: "Foo")
        let request = try endpoint.makeRequest()
        
        requestAdapter.adapt(request, for: session) { response in
            switch response {
            case .success(let request):
                XCTAssertEqual(
                    request.url?.absoluteString,
                    "http://image.tmdb.org/t/p/w500/Foo")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testAdaptAvatarRequest() throws {
        let endpoint = AvatarEndpoint(imagePath: "Foo")
        let request = try endpoint.makeRequest()
        
        requestAdapter.adapt(request, for: session) { response in
            switch response {
            case .success(let request):
                XCTAssertEqual(
                    request.url?.absoluteString,
                    "http://gravatar.com/avatar/Foo")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}
