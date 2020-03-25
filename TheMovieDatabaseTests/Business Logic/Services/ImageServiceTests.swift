//
//  ImageServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 24.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class ImageServiceTests: XCTestCase {
    
    // MARK: - Public Properties
    
    var imageService: ImageServiceType!
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        imageService = ServiceLayer.shared.imageService
    }
    
    // MARK: - Tests
    
    func testLoadAvatar() {
        let exp = expectation(description: "Загрузка аватара пользователя")
        imageService.avatar(avatarPath: "fd1768eb661e05f867255daf52f80413") { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testLoadMoviePoster() {
        let exp = expectation(description: "Загрузка постера фильма")
        imageService.image(posterPath: "aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg", width: nil) { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testLoadMoviePosterWithInvalidPath() {
        let exp = expectation(description: "Загрузка постера фильма")
        imageService.image(posterPath: "test", width: nil) { response in
            switch response {
            case .success:
                XCTFail("Введен неверный путь к постеру")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Запрашиваемый ресурс не найден.")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
