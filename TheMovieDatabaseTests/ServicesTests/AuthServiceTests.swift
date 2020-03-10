//
//  AuthServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

class AuthServiceTests: XCTestCase {
    
    let authService: Authorization = ServiceLayer.shared.authService
    
    func testInputFilledFields() {
        authService.validateUserInput(login: "Foo", password: "Barr") { response in
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
        authService.validateUserInput(login: nil, password: nil) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputNilLoginField() {
        authService.validateUserInput(login: nil, password: "Foo") { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputNilPasswordField() {
        authService.validateUserInput(login: "Foo", password: nil) { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputBlankFields() {
        authService.validateUserInput(login: "", password: "") { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputBlankLoginField() {
        authService.validateUserInput(login: "", password: "Foo") { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputBlankPasswordField() {
        authService.validateUserInput(login: "Foo", password: "") { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: поля не заполнены")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.blankFields)
            }
        }
    }
    
    func testInputInvalidData() {
        let user = User(login: "Foo", password: "Bar")
        authService.authorizeWithUser(user: user) { response in
            switch response {
            case .success:
                XCTFail("Ошибка авторизации: неверный логин или пароль")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.invalidInput)
            }
        }
    }
    
    func testInputValidData() {
        let user = User(login: "onl1steam", password: "Onl1sTeam")
        authService.authorizeWithUser(user: user) { response in
            switch response {
            case .success(let sessionId):
                XCTAssertNotEqual(sessionId, "")
            case .failure:
                XCTFail("Ошибка авторизации: введен верный логин или пароль")
            }
        }
    }
    
    func testInvalidPasswordLength() {
        authService.validateUserInput(login: "Foo", password: "Bar") { response in
            switch response {
            case .success:
                XCTFail("Ошибка валидации: пароль короче 4 символов")
            case .failure(let error):
                XCTAssertEqual(error, AuthError.invalidPasswordLength)
            }
        }
    }
}
