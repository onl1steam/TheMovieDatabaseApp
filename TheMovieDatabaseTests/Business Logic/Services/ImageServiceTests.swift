//
//  ImageServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
@testable import TheMovieDatabaseAPI
import XCTest

final class ImageServiceTests: XCTestCase {
    
    // MARK: - Public Properties
    
    var imageService: ImageServiceType!
    var response: Data!
    var apiClient: MockAPIClient!
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        response = Data()
        apiClient = MockAPIClient()
        imageService = ImageService(imageApiClient: apiClient)
    }
    
    // MARK: - Tests
    
    func testLoadAvatar() {
        let exp = expectation(description: "Загрузка изображений")
        
        imageService.avatar(avatarPath: "fd1768eb661e05f867255daf52f80413") { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        _ = apiClient.fulfil(AvatarEndpoint.self, with: response)
        wait(for: [exp], timeout: 5)
    }
    
    func testLoadMoviePoster() {
        let exp = expectation(description: "Загрузка изображений")
        
        imageService.image(posterPath: "aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg", width: nil) { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        
        _ = apiClient.fulfil(ImageEndpoint.self, with: response)
        wait(for: [exp], timeout: 5)
    }
    
    func testLoadMoviePosterWithInvalidPath() {
        let exp = expectation(description: "Загрузка изображений")
        
        imageService.image(posterPath: "test", width: nil) { response in
            switch response {
            case .success:
                XCTFail("Введен неверный путь к постеру")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Запрашиваемый ресурс не найден.")
            }
            exp.fulfill()
        }
        
        _ = apiClient.fail(ImageEndpoint.self, with: NetworkError.notFound)
        wait(for: [exp], timeout: 5)
    }
}
