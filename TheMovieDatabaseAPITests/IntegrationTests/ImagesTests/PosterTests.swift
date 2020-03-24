//
//  PosterTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class PosterTests: XCTestCase {
    
    // MARK: - Properties
    
    let baseURL = NetworkSettings.baseURL
    let apiKey = NetworkSettings.apiKey
    let apiClient = NetworkSettings.imageClient
    
    // MARK: - Tests
    
    func testLoadingPoster() {
        let expectation = self.expectation(description: "Получаем постер фильма")
        let endpoint = ImageEndpoint(width: nil, imagePath: "/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg")
        apiClient.request(endpoint) { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Изображение не загружено: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testLoadingInvalidPoster() {
        let expectation = self.expectation(description: "Получаем постер фильма")
        let endpoint = ImageEndpoint(width: nil, imagePath: "/test")
        apiClient.request(endpoint) { response in
            switch response {
            case .success:
                XCTFail("Изображение не должно быть найдено")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.notFound.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
