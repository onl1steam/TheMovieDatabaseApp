//
//  Authorization.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

final class Authorization: XCTestCase {
    
    static let baseURL = NetworkSettings.baseURL
    static let apiKey = NetworkSettings.apiKey
    static let apiClient: APIClient = NetworkSettings.apiClient
    
    static var sessionId: String?
    static var requestToken: String?
    
    static func authorize(_ completion: @escaping (Result<SessionInfoModel, Error>) -> Void) {
        if let requestToken = Authorization.requestToken,
            let sessionId = Authorization.sessionId {
            completion(.success(SessionInfoModel(requestToken: requestToken, sessionId: sessionId)))
        } else {
            createToken(completion)
        }
    }
    
    private static func createToken(_ completion: @escaping (Result<SessionInfoModel, Error>) -> Void) {
        let createTokenEndpoint = CreateTokenEndpoint()
        apiClient.request(createTokenEndpoint) { response in
            switch response {
            case .success(let content):
                self.validateSession(token: content.requestToken, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func validateSession(
        token: String,
        _ completion: @escaping (Result<SessionInfoModel, Error>) -> Void) {
        let createLoginSessionEndpoint = CreateLoginSessionEndpoint(
            username: "onl1steam",
            password: "Onl1sTeam",
            requestToken: token)
        apiClient.request(createLoginSessionEndpoint) { response in
            switch response {
            case .success(let content):
                self.getSessionId(token: content.requestToken, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func getSessionId(token: String, _ completion: @escaping (Result<SessionInfoModel, Error>) -> Void) {
        let createSession = CreateSessionEndpoint(requestToken: token)
        apiClient.request(createSession) { response in
            switch response {
            case .success(let content):
                let model = SessionInfoModel(requestToken: token, sessionId: content.sessionId)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
