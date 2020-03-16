//
//  SearchMovieEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для поиска фильмов.
public struct SearchMovieEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = MoviesResponse
    
    // MARK: - Public Properties
    
    let baseURL: URL
    let apiKey: String
    let query: String
    let language: String?
    let page: Int?
    
    // MARK: - Initializers
    
    public init(baseURL: URL, apiKey: String, query: String, language: String?, page: Int?) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.query = query
        self.language = language
        self.page = page
    }
    
    // MARK: - Endpoint
    
    public func makeRequest() throws -> URLRequest {
        let queryItems = makeQueryItems()
        let url = makeURLPath()
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else { throw NetworkError.badURL }
        let request = URLRequest(url: resultURL)
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        guard let resp = response as? HTTPURLResponse else { throw NetworkError.unknownError }
        guard (200...300).contains(resp.statusCode) else {
            switch resp.statusCode {
            case 401:
                throw NetworkError.unauthorized
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.unknownError
            }
        }
        guard let data = from else { throw NetworkError.blankData }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let item = try decoder.decode(MoviesResponse.self, from: data)
            return item
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Private Methods
    
    private func makeQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        let searchQuery = URLQueryItem(name: "query", value: query)
        if let lang = language {
            let langQuery = URLQueryItem(name: "language", value: lang)
            queryItems.append(langQuery)
        }
        if let page = page {
            let pageQuery = URLQueryItem(name: "page", value: "\(page)")
            queryItems.append(pageQuery)
        }
        queryItems.append(searchQuery)
        queryItems.append(apiKeyQuery)
        return queryItems
    }
    
    private func makeURLPath() -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("search")
        url.appendPathComponent("movie")
        return url
    }
}
