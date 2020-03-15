//
//  SessionService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

/// Управляет текущей сессией пользователя.
protocol Session {
    
    /// Удаляет текущую сессию пользователя.
    func deleteSession()
    
    /// Устанавливает id текущей сессии.
    ///
    /// - Parameters:
    ///   - sessionId: id сессии.
    func setupSessionId(sessionId: String)
    
    /// Возвращает информацию об аккаунте.
    ///
    /// - Parameters:
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа AccountResponse или ошибку.
    func getAccountInfo(_ completion: @escaping (Result<AccountResponse, Error>) -> Void)
}

class SessionService: Session {
    
    // MARK: - Private Properties
    
    let baseURL = URL(string: "https://api.themoviedb.org/")!
    let apiKey = "591efe0e25fd45c1579562958b2364db"
    
    private(set) var sessionId = ""
    let apiClient: APIClient
    
    var accountInfo: AccountResponse?
    
    init(apiClient: APIClient = APIRequest()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Session
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
    
    func deleteSession() {
        let deleteSessionEndpoint = DeleteSessionEndpoint(baseURL: baseURL, apiKey: apiKey, sessionId: sessionId)
        apiClient.request(deleteSessionEndpoint) { response in
            switch response {
            case .success(let isSucceed):
                print(isSucceed)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAccountInfo(_ completion: @escaping (Result<AccountResponse, Error>) -> Void) {
        let endpoint = AccountDetailsEndpoint(baseURL: baseURL, apiKey: apiKey, sessionId: sessionId)
        apiClient.request(endpoint) { response in
            switch response {
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
