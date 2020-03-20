//
//  FavoriteMoviesEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для для получения списка избранных фильмов.
public struct FavoriteMoviesEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = MoviesResponse
    
    // MARK: - Public Properties

    let baseURL: URL
    let apiKey: String
    let sessionId: String
    let accountId: Int?
    let language: String?
    let sortBy: String?
    let page: Int?
    
    // MARK: - Initializers
    
    public init(
        baseURL: URL,
        apiKey: String,
        sessionId: String,
        accountId: Int?,
        language: String?,
        sortBy: String?,
        page: Int?) {
        
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.sessionId = sessionId
        self.accountId = accountId
        self.language = language
        self.sortBy = sortBy
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
        guard let resp = response as? HTTPURLResponse else { throw NetworkError.noHTTPResponse }
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
            throw error
        }
    }
    
    // MARK: - Private Methods
    
    private func makeQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        let sessionIdQuery = URLQueryItem(name: "session_id", value: sessionId)
        
        if let lang = language {
            let langQuery = URLQueryItem(name: "language", value: lang)
            queryItems.append(langQuery)
        }
        if let sortBy = sortBy {
            let sortQuery = URLQueryItem(name: "sort_by", value: sortBy)
            queryItems.append(sortQuery)
        }
        if let page = page {
            let pageQuery = URLQueryItem(name: "page", value: "\(page)")
            queryItems.append(pageQuery)
        }
        queryItems.append(apiKeyQuery)
        queryItems.append(sessionIdQuery)
        return queryItems
    }
    
    private func makeURLPath() -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("account")
        if let accId = accountId {
            url.appendPathComponent("\(accId)")
        } else {
            url.appendPathComponent("{account_id}")
        }
        url.appendPathComponent("favorite")
        url.appendPathComponent("movies")
        return url
    }
}
