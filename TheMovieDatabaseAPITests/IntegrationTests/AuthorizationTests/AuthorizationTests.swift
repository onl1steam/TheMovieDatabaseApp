//
//  AuthorizationTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

final class AuthorizationTests: XCTestCase {
    
    // MARK: - Public Properties
    
    let baseURL = NetworkSettings.baseURL
    let apiKey = NetworkSettings.apiKey
    let apiClient = NetworkSettings.apiClient
    
    // MARK: - Tests
    
    func testLoadingToken() {
        let expectation = self.expectation(description: "Получение токена")
        let createTokenEndpoint = CreateTokenEndpoint()
        apiClient.request(createTokenEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertNotEqual(content, "")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testCreatingLoginSession() {
        let expectation = self.expectation(description: "Валидация сессии")
        let createTokenEndpoint = CreateTokenEndpoint()
        apiClient.request(createTokenEndpoint) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let content):
                self.createLoginSessionTest(requestToken: content, expectation: expectation)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testCreatingSession() {
        let expectation = self.expectation(description: "Создание сессии")
        let createTokenEndpoint = CreateTokenEndpoint()
        apiClient.request(createTokenEndpoint) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let content):
                self.createLoginSession(requestToken: content, expectation: expectation)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
    // MARK: - Methods
    
    func createLoginSessionTest(requestToken: String, expectation: XCTestExpectation) {
        let createLoginSessionEndpoint = CreateLoginSessionEndpoint(
            username: "onl1steam",
            password: "Onl1sTeam",
            requestToken: requestToken)
        apiClient.request(createLoginSessionEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertEqual(requestToken, content)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func createLoginSession(requestToken: String, expectation: XCTestExpectation) {
        let createLoginSessionEndpoint = CreateLoginSessionEndpoint(
            username: "onl1steam",
            password: "Onl1sTeam",
            requestToken: requestToken)
        apiClient.request(createLoginSessionEndpoint) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let content):
                self.createSessionTest(requestToken: content, expectation: expectation)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func createSessionTest(requestToken: String, expectation: XCTestExpectation) {
        let createSession = CreateSessionEndpoint(requestToken: requestToken)
        apiClient.request(createSession) { response in
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertNotEqual(content, "")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
