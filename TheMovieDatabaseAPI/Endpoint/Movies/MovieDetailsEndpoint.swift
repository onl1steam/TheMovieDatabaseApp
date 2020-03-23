//
//  MovieDetailsEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для получения детальной информации о фильме.
public struct MovieDetailsEndpoint: Endpoint {
    
    // MARK: - Types

    public typealias Content = MovieDetailsResponse
    
    // MARK: - Public Properties
    
    let movieId: Int
    let language: String?
    
    public var configuration: Configuration?
    
    // MARK: - Initializers
    
    public init(movieId: Int, language: String?) {
        self.movieId = movieId
        self.language = language
    }
    
    // MARK: - Endpoint
    
    public func makeRequest() throws -> URLRequest {
        guard let configuration = configuration else { throw NetworkError.noConfiguration }
        
        let url = makeURLPath(baseURL: configuration.baseURL)
        let queryItems = makeQueryItems(apiKey: configuration.apiKey)
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else { throw NetworkError.badURL }
        var request = URLRequest(url: resultURL)
        request.httpMethod = HttpMethods.GET.rawValue
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
        let data = try EndpointDefaultMethods.parseDecodable(data: from, decodableType: Content.self)
        return data
    }
    
    // MARK: - Private Methods
    
    private func makeQueryItems(apiKey: String) -> [URLQueryItem] {
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        if let lang = language {
            let langQuery = URLQueryItem(name: "language", value: lang)
            queryItems.append(langQuery)
        }
        return queryItems
    }
    
    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("movie")
        url.appendPathComponent("\(movieId)")
        return url
    }
}
