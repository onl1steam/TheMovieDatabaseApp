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
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        response = Data()
    }
    
    // MARK: - Tests
    
    func testLoadAvatar() {
        let apiClient = APIClientStub(responseStub: response, errorStub: nil)
        imageService = ImageService(imageApiClient: apiClient)
        
        imageService.avatar(avatarPath: "fd1768eb661e05f867255daf52f80413") { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func testLoadMoviePoster() {
        let apiClient = APIClientStub(responseStub: response, errorStub: nil)
        imageService = ImageService(imageApiClient: apiClient)
        
        imageService.image(posterPath: "aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg", width: nil) { response in
            switch response {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Ошибка: \(error.localizedDescription)")
            }
        }
    }
    
    func testLoadMoviePosterWithInvalidPath() {
        let apiClient = APIClientStub(responseStub: nil, errorStub: NetworkError.notFound)
        imageService = ImageService(imageApiClient: apiClient)
        
        imageService.image(posterPath: "test", width: nil) { response in
            switch response {
            case .success:
                XCTFail("Введен неверный путь к постеру")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Запрашиваемый ресурс не найден.")
            }
        }
    }
}
