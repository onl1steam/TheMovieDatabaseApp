//
//  AuthServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class AuthServiceTests: XCTestCase {
    
    let authService: Authorization = ServiceLayer.shared.authService
    
    func testInputFilledFields() {
        let user = User(login: "Foo", password: "Barr")
        authService.validateUserInput(user: user) { response in
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
        authService.validateUserInput(user: user) { response in
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
        authService.validateUserInput(user: user) { response in
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
        authService.validateUserInput(user: user) { response in
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
        authService.validateUserInput(user: user) { response in
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
        authService.validateUserInput(user: user) { response in
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
        authService.validateUserInput(user: user) { response in
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
        authService.validateUserInput(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: пароль короче 4 символов")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.invalidPasswordLength)
            }
        }
    }
}
