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
    
    let sessionId: String
    let accountId: Int?
    let language: String?
    let sortBy: String?
    let page: Int?
    
    // MARK: - Initializers
    
    public init(
        sessionId: String,
        accountId: Int?,
        language: String?,
        sortBy: String?,
        page: Int?) {
        
        self.sessionId = sessionId
        self.accountId = accountId
        self.language = language
        self.sortBy = sortBy
        self.page = page
    }
    
    // MARK: - Endpoint
    
    public func makeRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        guard let componentsUrl = urlComponents.url else { throw NetworkError.badURL }
        
        let urlPath = makeURLPath(baseURL: componentsUrl)
        urlComponents.path = urlPath.absoluteString
        urlComponents.queryItems = makeQueryItems()
        guard let resultURL = urlComponents.url else { throw NetworkError.badURL }
        
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
    
    private func makeQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: "session_id", value: sessionId)]
        
        if let lang = language {
            queryItems.append(URLQueryItem(name: "language", value: lang))
        }
        if let sortBy = sortBy {
            queryItems.append(URLQueryItem(name: "sort_by", value: sortBy))
        }
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        return queryItems
    }
    
    private func makeURLPath(baseURL: URL) -> URL {
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
