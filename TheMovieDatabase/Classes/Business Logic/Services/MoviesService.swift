//
//  MoviesService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

protocol MoviesServiceType {
    
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
}

class MoviesService: MoviesServiceType {
    
    let baseUrl = NetworkConfiguration.baseURL
    let apiKey = NetworkConfiguration.apiKey
    let apiClient: APIClient
    
    init(apiClient: APIClient = APIRequest()) {
        self.apiClient = apiClient
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
