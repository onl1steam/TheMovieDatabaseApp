//
//  DeleteSessionEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для удаления сессии.
public struct DeleteSessionEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = Bool
    
    // MARK: - Public Properties
    
    let sessionId: String
    
    public var configuration: Configuration?

    // MARK: - Initializers
    
    public init(sessionId: String) {
        self.sessionId = sessionId
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
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        
        let encodableData = DeleteSessionBody(sessionId: sessionId)
        let data = try EndpointDefaultMethods.encodeBody(data: encodableData)
        request.httpBody = data
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
        let data = try EndpointDefaultMethods.parseDecodable(data: from, decodableType: DeleteSessionResponse.self)
        return data.success
    }
    
    // MARK: - Private Methods
    
    private func makeQueryItems(apiKey: String) -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        return queryItems
    }
    
    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("authentication")
        url.appendPathComponent("session")
        return url
    }
}
