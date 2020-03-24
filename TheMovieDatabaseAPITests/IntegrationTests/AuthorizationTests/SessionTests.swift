//
//  SessionTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

final class SessionTests: XCTestCase {
    
    // MARK: - Properties
    
    var apiClient: APIClient!
    var sessionId: String!
    
    override func setUp() {
        super.setUp()
        let exp = expectation(description: "Авторизация")
        apiClient = NetworkSettings.apiClient
        createSession { [weak self] response in
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
    
    func testDeletingSession() {
        let expectation = self.expectation(description: "Удаление сессии")
        let deleteSessionEndpoint = DeleteSessionEndpoint(sessionId: sessionId)
        apiClient.request(deleteSessionEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let isSucceed):
                XCTAssert(isSucceed)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
     // MARK: - Methods
    
    func createSession(_ completion: @escaping (Result<SessionInfoModel, Error>) -> Void) {
        let authorization: AuthorizationType = Authorization()
        authorization.authorize(completion)
    }
}
