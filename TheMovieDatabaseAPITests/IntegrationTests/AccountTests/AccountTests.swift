//
//  AccountTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 18.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

final class AccountTests: XCTestCase {
    
    // MARK: - Public Properties
    
    var apiClient: APIClient!
    var sessionId: String!
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        let exp = expectation(description: "Авторизация")
        apiClient = NetworkSettings.apiClient
        Authorization.authorize { [weak self] response in
            switch response {
            case .success(let sessionInfo):
                self?.sessionId = sessionInfo.sessionId
            case .failure(let error):
                XCTFail("Ошибка авторизации: \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    // MARK: - Tests
    
    func testLoadingAccountDetails() {
        let exp = expectation(description: "Получение информации об аккаунте")
        let accountDetailsEndpoint = AccountDetailsEndpoint(sessionId: sessionId)
        apiClient.request(accountDetailsEndpoint) { response in
            switch response {
            case .success(let content):
                XCTAssertEqual(content.username, "onl1steam")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
