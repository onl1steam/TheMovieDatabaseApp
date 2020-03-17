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
    
    /// Устанавливает id аккаунта.
    ///
    /// - Parameters:
    ///   - accountId: id аккаунта.
    func setupAccountId(accountId: Int)
    
    /// Возвращает информацию об аккаунте.
    ///
    /// - Parameters:
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа AccountResponse или ошибку.
    func getAccountInfo(_ completion: @escaping (Result<AccountResponse, Error>) -> Void)
    
    /// Возвращает список избранных фильмов пользователя.
    ///
    /// - Parameters:
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа MoviesResponse или ошибку.
    func getFavorites(_ completion: @escaping (Result<MoviesResponse, Error>) -> Void)
}

class SessionService: Session {
    
    // MARK: - Public Properties
    
    let baseUrl = NetworkConfiguration.baseURL
    let apiKey = NetworkConfiguration.apiKey
    let apiClient: APIClient
    
    // MARK: - Private Properties
    
    private(set) var sessionId: String?
    private(set) var accountId: Int?
    
    // MARK: - Initializers
    
    init(apiClient: APIClient = APIRequest()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Session
    
    func deleteSession() {
        guard let sessionId = sessionId else { return }
        let deleteSessionEndpoint = DeleteSessionEndpoint(baseURL: baseUrl, apiKey: apiKey, sessionId: sessionId)
        apiClient.request(deleteSessionEndpoint) { response in
            switch response {
            case .success(let isSucceed):
                print(isSucceed)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.sessionId = nil
            self.accountId = nil
        }
    }
    
    func getAccountInfo(_ completion: @escaping (Result<AccountResponse, Error>) -> Void) {
        guard let sessionId = sessionId else { return }
        let endpoint = AccountDetailsEndpoint(baseURL: baseUrl, apiKey: apiKey, sessionId: sessionId)
        request(endpoint: endpoint, completion)
    }
    
    func getFavorites(_ completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        guard let sessionId = sessionId, let accountId = accountId else { return }
        let endpoint = FavoriteMoviesEndpoint(
            baseURL: baseUrl,
            apiKey: apiKey,
            sessionId: sessionId,
            accountId: accountId,
            language: nil,
            sortBy: nil,
            page: nil)
        request(endpoint: endpoint, completion)
    }
    
    func setupAccountId(accountId: Int) {
        self.accountId = accountId
    }
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
    
    // MARK: - Private Methods
    
    private func request<T>(endpoint: T, _ completion: @escaping (Result<T.Content, Error>) -> Void) where T: Endpoint {
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
