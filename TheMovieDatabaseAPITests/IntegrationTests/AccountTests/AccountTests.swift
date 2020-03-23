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
    
    // MARK: - Properties
    
    let baseURL = NetworkSettings.baseURL
    let apiKey = NetworkSettings.apiKey
    let apiClient = NetworkSettings.apiClient
    
    // MARK: - Tests
    
    func testLoadingAccountDetails() {
        let expectation = self.expectation(description: "Удаление сессии")
        createSession(expectation: expectation, loadAccountDetailsTest)
        wait(for: [expectation], timeout: 40.0)
    }
    
     // MARK: - Methods
    
    func loadAccountDetailsTest(expectation: XCTestExpectation, sessionId: String) {
        let accountDetailsEndpoint = AccountDetailsEndpoint(sessionId: sessionId)
        apiClient.request(accountDetailsEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let content):
                XCTAssertEqual(content.username, "onl1steam")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func createSession(
        expectation: XCTestExpectation,
        _ completion: @escaping (_ expectation: XCTestExpectation, _ sessionId: String) -> Void) {
        
        let authorization: AuthorizationType = Authorization()
        authorization.authorize { response in
            switch response {
            case .success(let content):
                completion(expectation, content.sessionId)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
