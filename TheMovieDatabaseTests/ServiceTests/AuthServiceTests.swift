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
        let response = authService.validateUserInput(login: "Foo", password: "Bar")
        switch response {
        case .success(let user):
            XCTAssertEqual(user.login, "Foo")
            XCTAssertEqual(user.password, "Bar")
        case .failure:
            XCTFail("Ошибка валидации: все поля заполнены")
        }
    }

    func testInputNilFields() {
        let response = authService.validateUserInput(login: nil, password: nil)
        switch response {
        case .success:
            XCTFail("Ошибка валидации: поля не заполнены")
        case .failure(let error):
            XCTAssertEqual(error, AuthError.blankFields)
        }
    }
    
    func testInputNilLoginField() {
        let response = authService.validateUserInput(login: nil, password: "Foo")
        switch response {
        case .success:
            XCTFail("Ошибка валидации: поля не заполнены")
        case .failure(let error):
            XCTAssertEqual(error, AuthError.blankFields)
        }
    }
    
    func testInputNilPasswordField() {
        let response = authService.validateUserInput(login: "Foo", password: nil)
        switch response {
        case .success:
            XCTFail("Ошибка валидации: поля не заполнены")
        case .failure(let error):
            XCTAssertEqual(error, AuthError.blankFields)
        }
    }
    
    func testInputBlankFields() {
        let response = authService.validateUserInput(login: "", password: "")
        switch response {
        case .success:
            XCTFail("Ошибка валидации: поля не заполнены")
        case .failure(let error):
            XCTAssertEqual(error, AuthError.blankFields)
        }
    }
    
    func testInputBlankLoginField() {
        let response = authService.validateUserInput(login: "", password: "Foo")
        switch response {
        case .success:
            XCTFail("Ошибка валидации: поля не заполнены")
        case .failure(let error):
            XCTAssertEqual(error, AuthError.blankFields)
        }
    }
    
    func testInputBlankPasswordField() {
        let response = authService.validateUserInput(login: "Foo", password: "")
        switch response {
        case .success:
            XCTFail("Ошибка валидации: поля не заполнены")
        case .failure(let error):
            XCTAssertEqual(error, AuthError.blankFields)
        }
    }
    
    func testInputIncorrectData() {
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
    
    func testInputCorrectData() {
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
}
