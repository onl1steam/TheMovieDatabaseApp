//
//  SessionTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class SessionTests: XCTestCase {
    
    let baseURL = URL(string: "https://api.themoviedb.org/")!
    let apiKey = "591efe0e25fd45c1579562958b2364db"
    let apiClient: APIClient = APIRequest()
    
    func testDeletingSession() {
        let expectation = self.expectation(description: "Удаление сессии")
        createSession(expectation: expectation, deleteSessionTest)
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    private func deleteSessionTest(expectation: XCTestExpectation, sessionId: String) {
        let deleteSessionEndpoint = DeleteSessionEndpoint(baseURL: baseURL, apiKey: apiKey, sessionId: sessionId)
        apiClient.request(deleteSessionEndpoint) { response in
            expectation.fulfill()
            switch response {
            case .success(let isSucceed):
                XCTAssert(isSucceed)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    private func createSession(
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
