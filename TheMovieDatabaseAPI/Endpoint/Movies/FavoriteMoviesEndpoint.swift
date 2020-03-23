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
    
    public enum Filter: String {
        case createdAtAsc = "created_at.asc"
        case createdAtDesc = "created_at.desc"
    }
    
    // MARK: - Public Properties
    
    let sessionId: String
    let accountId: Int?
    let language: String?
    let sortBy: Filter?
    let page: Int?
    
    public var configuration: Configuration?
    
    // MARK: - Initializers
    
    public init(
        sessionId: String,
        accountId: Int?,
        language: String?,
        sortBy: Filter?,
        page: Int?) {
        
        self.sessionId = sessionId
        self.accountId = accountId
        self.language = language
        self.sortBy = sortBy
        self.page = page
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
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "session_id", value: sessionId)]
        
        if let lang = language {
            let langQuery = URLQueryItem(name: "language", value: lang)
            queryItems.append(langQuery)
        }
        if let sortBy = sortBy {
            let sortQuery = URLQueryItem(name: "sort_by", value: sortBy.rawValue)
            queryItems.append(sortQuery)
        }
        if let page = page {
            let pageQuery = URLQueryItem(name: "page", value: "\(page)")
            queryItems.append(pageQuery)
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