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
    
    /// Возвращает информацию об аккаунте.
    ///
    /// - Parameters:
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа MoviesResponse или ошибку.
    func getFavorites(_ completion: @escaping (Result<MoviesResponse, Error>) -> Void)
    
    /// Возвращает информацию об аккаунте.
    ///
    /// - Parameters:
    ///   - query: Строка поиска фильма.
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа MoviesResponse или ошибку.
    func findMovies(query: String, _ completion: @escaping (Result<MoviesResponse, Error>) -> Void)
    
    /// Возвращает информацию об аккаунте.
    ///
    /// - Parameters:
    ///   - movieId: Id фильма.
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа MovieDetailsResponse или ошибку.
    func getMovieDetails(
        movieId: Int,
        language: String?,
        _ completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void)
    
    @discardableResult
    func getImage(posterPath: String, width: String?, _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress
    
    @discardableResult
    func getAvatar(avatarPath: String, _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress
}

class SessionService: Session {
    
    // MARK: - Private Properties
    
    let baseUrl = NetworkConfiguration.baseURL
    let imageBaseUrl = NetworkConfiguration.imageBaseURL
    let avatarBaseUrl = NetworkConfiguration.avatarBaseURL
    let apiKey = NetworkConfiguration.apiKey
    
    private(set) var sessionId = ""
    private(set) var accountId = 0
    let apiClient: APIClient
    let imageApiClient: APIClient
    
    var accountInfo: AccountResponse?
    
    init(apiClient: APIClient = APIRequest(), imageApiClient: APIClient = APIRequestImage()) {
        self.apiClient = apiClient
        self.imageApiClient = imageApiClient
    }
    
    // MARK: - Session
    
    func deleteSession() {
        let deleteSessionEndpoint = DeleteSessionEndpoint(baseURL: baseUrl, apiKey: apiKey, sessionId: sessionId)
        apiClient.request(deleteSessionEndpoint) { response in
            switch response {
            case .success(let isSucceed):
                print(isSucceed)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.sessionId = ""
            self.accountId = 0
        }
    }
    
    func getAccountInfo(_ completion: @escaping (Result<AccountResponse, Error>) -> Void) {
        let endpoint = AccountDetailsEndpoint(baseURL: baseUrl, apiKey: apiKey, sessionId: sessionId)
        request(endpoint: endpoint, completion)
    }
    
    func getFavorites(_ completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
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
    
    func findMovies(query: String, _ completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        let endpoint = SearchMovieEndpoint(baseURL: baseUrl, apiKey: apiKey, query: query, language: nil, page: nil)
        request(endpoint: endpoint, completion)
    }
    
    func getMovieDetails(
        movieId: Int,
        language: String?,
        _ completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) {
        let endpoint = MovieDetailsEndpoint(baseURL: baseUrl, apiKey: apiKey, movieId: movieId, language: language)
        request(endpoint: endpoint, completion)
    }
    
    @discardableResult
    func getImage(
        posterPath: String,
        width: String?,
        _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress {
        let endpoint = ImageEndpoint(baseURL: imageBaseUrl, width: width, imagePath: posterPath)
        let progress = imageApiClient.request(endpoint) { response in
            switch response {
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return progress
    }
    
    @discardableResult
    func getAvatar(avatarPath: String, _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress {
        let endpoint = AvatarEndpoint(baseURL: avatarBaseUrl, imagePath: avatarPath)
        let progress = imageApiClient.request(endpoint) { response in
            switch response {
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return progress
    }
    
    func setupAccountId(accountId: Int) {
        self.accountId = accountId
    }
    
    func setupSessionId(sessionId: String) {
        self.sessionId = sessionId
    }
    
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
