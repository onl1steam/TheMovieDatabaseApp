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
    /// - Parameters:
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа AccountResponse или ошибку.
    func deleteSession(_ completion: @escaping (Result<Bool, Error>) -> Void)
    
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
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа AccountDetails или ошибку.
    func accountInfo(_ completion: @escaping (Result<AccountDetails, Error>) -> Void)
    
    /// Возвращает список избранных фильмов пользователя.
    ///
    /// - Parameters:
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа MoviesResponse или ошибку.
    func favoriteMovies(
        language: String?,
        sortBy: String?,
        page: Int?,
        _ completion: @escaping (Result<MovieList, Error>) -> Void)
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
    
    func deleteSession(_ completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let sessionId = sessionId else { return }
        let deleteSessionEndpoint = DeleteSessionEndpoint(sessionId: sessionId)
        apiClient.request(deleteSessionEndpoint) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let deleteSessionResponse):
                completion(.success(deleteSessionResponse.success))
            case .failure(let error):
                completion(.failure(error))
            }
            self.sessionId = nil
            self.accountId = nil
        }
    }
    
    func accountInfo(_ completion: @escaping (Result<AccountDetails, Error>) -> Void) {
        guard let sessionId = sessionId else { return }
        let endpoint = AccountDetailsEndpoint(sessionId: sessionId)
        apiClient.request(endpoint) { response in
            switch response {
            case .success(let details):
                let accountDetails = AccountDetails(accountResponse: details)
                completion(.success(accountDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func favoriteMovies(
        language: String?,
        sortBy: String?,
        page: Int?,
        _ completion: @escaping (Result<MovieList, Error>) -> Void) {
        
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
        apiClient.request(endpoint) { response in
            switch response {
            case .success(let moviesResponse):
                let moviesList = MovieList(moviesResponse: moviesResponse)
                completion(.success(moviesList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setupAccountId(accountId: Int) {
        self.accountId = accountId
    }
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
}
