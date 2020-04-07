//
//  MarkFavoriteEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 07.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Добавление или удаление фильма из избранного.
public struct MarkFavoriteEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = Void
    
    // MARK: - Public Properties
    
    let sessionId: String
    let accountId: Int?
    let mediaType: String
    let mediaId: Int
    let favorite: Bool
    
    // MARK: - Initializers
    
    public init(
        sessionId: String,
        accountId: Int?,
        mediaType: String,
        mediaId: Int,
        favorite: Bool) {
        
        self.sessionId = sessionId
        self.accountId = accountId
        self.mediaType = mediaType
        self.mediaId = mediaId
        self.favorite = favorite
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
        
        let encodableData = MarkFavoriteBody(mediaType: mediaType, mediaId: mediaId, favorite: favorite)
        let data = try EndpointDefaultMethods.encodeBody(data: encodableData)
        
        request.httpMethod = HttpMethods.POST.rawValue
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        request.httpBody = data
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
    }
    
    // MARK: - Private Methods
    
    private func makeQueryItems() -> [URLQueryItem] {
        let queryItems = [URLQueryItem(name: "session_id", value: sessionId)]
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
        return url
    }
}
