//
//  ValidationServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class ValidationServiceTests: XCTestCase {
    
    // MARK: - Public Properties
    
    var validationService: Validation!
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        validationService = ServiceLayer.shared.validationService
    }
    
    // MARK: - Tests
    
    func testInputFilledFields() {
        let user = User(login: "Foo", password: "Barr")
        validationService.validateUserInput(user: user) { response in
            switch response {
            case .success(let user):
                XCTAssertEqual(user.login, "Foo")
                XCTAssertEqual(user.password, "Barr")
            case .failure:
                XCTFail("Ошибка валидации: все поля заполнены")
            }
        }
    }
    
    func testInputNilFields() {
        let user = User(login: nil, password: nil)
        validationService.validateUserInput(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputNilLoginField() {
        let user = User(login: nil, password: "Foo")
        validationService.validateUserInput(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputNilPasswordField() {
        let user = User(login: "Foo", password: nil)
        validationService.validateUserInput(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputBlankFields() {
        let user = User(login: "", password: "")
        validationService.validateUserInput(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputBlankLoginField() {
        let user = User(login: "", password: "Foo")
        validationService.validateUserInput(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputBlankPasswordField() {
        let user = User(login: "Foo", password: "")
        validationService.validateUserInput(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInvalidPasswordLength() {
        let user = User(login: "Foo", password: "Bar")
        validationService.validateUserInput(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: пароль короче 4 символов")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.invalidPasswordLength)
            }
        }
    }
}
