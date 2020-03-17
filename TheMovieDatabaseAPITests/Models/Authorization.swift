//
//  Authorization.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

/// Авторизирует в базе данных, используется в части setup теста.
protocol AuthorizationType {
    
    /// Авторизация в базе данных
    ///
    /// - Parameters:
    ///     - completion: Вызывается после окончания функции. Возвращает токен и id сессии при успехе или ошибку.
    func authorize(_ completion: @escaping (Result<SessionInfoModel, Error>) -> Void)
}

class Authorization: AuthorizationType {
    
    let baseURL = URL(string: "https://api.themoviedb.org/")!
    let apiKey = "591efe0e25fd45c1579562958b2364db"
    let apiClient: APIClient = APIRequest()
    
    func authorize(_ completion: @escaping (Result<SessionInfoModel, Error>) -> Void) {
        let createTokenEndpoint = CreateTokenEndpoint(baseURL: baseURL, apiKey: apiKey)
        apiClient.request(createTokenEndpoint) { response in
            switch response {
            case .success(let content):
                self.validateSession(token: content, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func validateSession(token: String, _ completion: @escaping (Result<SessionInfoModel, Error>) -> Void) {
        let createLoginSessionEndpoint = CreateLoginSessionEndpoint(
            baseURL: self.baseURL,
            apiKey: self.apiKey,
            username: "onl1steam",
            password: "Onl1sTeam",
            requestToken: token)
        apiClient.request(createLoginSessionEndpoint) { response in
            switch response {
            case .success(let content):
                self.getSessionId(token: content, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getSessionId(token: String, _ completion: @escaping (Result<SessionInfoModel, Error>) -> Void) {
        let createSession = CreateSessionEndpoint(baseURL: baseURL, apiKey: apiKey, requestToken: token)
        apiClient.request(createSession) { response in
            switch response {
            case .success(let content):
                let model = SessionInfoModel(requestToken: token, sessionId: content)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
