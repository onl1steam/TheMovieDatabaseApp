//
//  AvatarTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

@testable import TheMovieDatabaseAPI
import XCTest

final class AvatarTests: XCTestCase {
    
    // MARK: - Public Properties
    
    let baseURL = NetworkSettings.baseURL
    let apiKey = NetworkSettings.apiKey
    let apiClient = NetworkSettings.imageClient
    
    // MARK: - Tests
    
    func testLoadingAvatar() {
        let expectation = self.expectation(description: "Получаем аватар пользователя")
        let endpoint = AvatarEndpoint(imagePath: "/fd1768eb661e05f867255daf52f80413")
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
}
