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
    func accountInfo(_ completion: @escaping (Result<AccountResponse, Error>) -> Void)
    
    /// Возвращает список избранных фильмов пользователя.
    ///
    /// - Parameters:
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа MoviesResponse или ошибку.
    func favoriteMovies(
        language: String?,
        sortBy: FavoriteMoviesEndpoint.Filter?,
        page: Int?,
        _ completion: @escaping (Result<MoviesResponse, Error>) -> Void)
}

final class SessionService: Session {
    
    // MARK: - Public Properties
    
    let baseUrl = NetworkConfiguration.baseURL
    let apiKey = NetworkConfiguration.apiKey
    let apiClient: APIClient
    
    // MARK: - Private Properties
    
    private(set) var sessionId: String?
    private(set) var accountId: Int?
    
    // MARK: - Initializers
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Session
    
    func deleteSession() {
        guard let sessionId = sessionId else { return }
        let deleteSessionEndpoint = DeleteSessionEndpoint(sessionId: sessionId)
        apiClient.request(deleteSessionEndpoint) { [weak self] response in
            guard let self = self else { return }
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
    
    func accountInfo(_ completion: @escaping (Result<AccountResponse, Error>) -> Void) {
        guard let sessionId = sessionId else { return }
        let endpoint = AccountDetailsEndpoint(sessionId: sessionId)
        apiClient.request(endpoint, completionHandler: completion)
    }
    
    func favoriteMovies(
        language: String?,
        sortBy: FavoriteMoviesEndpoint.Filter?,
        page: Int?,
        _ completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        
        guard let sessionId = sessionId else {
            completion(.failure(AuthError.noSessionId))
            return
        }
        let endpoint = FavoriteMoviesEndpoint(
            sessionId: sessionId,
            accountId: accountId,
            language: language,
            sortBy: sortBy,
            page: page)
        apiClient.request(endpoint, completionHandler: completion)
    }
    
    func setupAccountId(accountId: Int) {
        self.accountId = accountId
    }
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
}
