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
    
    /// Находит фильмы по поисковой строке.
    ///
    /// - Parameters:
    ///   - query: Строка поиска фильма.
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа MoviesResponse или ошибку.
    func searchMovies(query: String, _ completion: @escaping (Result<MovieList, Error>) -> Void)
    
    /// Возвращает подробную информацию о фильмо.
    ///
    /// - Parameters:
    ///   - movieId: Id фильма.
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ типа MovieDetailsResponse или ошибку.
    func movieDetails(
        movieId: Int,
        language: String?,
        _ completion: @escaping (Result<MovieDetails, Error>) -> Void)
}

final class MoviesService: MoviesServiceType {
    
    // MARK: - Public Properties
    
    let baseUrl = NetworkConfiguration.baseURL
    let apiKey = NetworkConfiguration.apiKey
    let apiClient: APIClient
    
    // MARK: - Initializers
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - MoviesServiceType
    
    func searchMovies(query: String, _ completion: @escaping (Result<MovieList, Error>) -> Void) {
        let endpoint = SearchMovieEndpoint(
            query: query,
            language: nil,
            page: nil,
            includeAdult: nil,
            region: nil,
            year: nil,
            primaryReleaseYear: nil)
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
    
    func movieDetails(
        movieId: Int,
        language: String?,
        _ completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        let endpoint = MovieDetailsEndpoint(movieId: movieId, language: language)
        apiClient.request(endpoint) { response in
            switch response {
            case .success(let movieDetailsResponse):
                let movieDetails = MovieDetails(movieDetailsResponse: movieDetailsResponse)
                completion(.success(movieDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
