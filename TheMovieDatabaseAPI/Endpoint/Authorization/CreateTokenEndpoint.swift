//
//  CreateTokenEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для создания токена сессии.
public struct CreateTokenEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = String
    
    // MARK: - Public Properties
    
    public var configuration: Configuration?
    
    // MARK: - Initializers
    
    public init() {}
    
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
        let data = try EndpointDefaultMethods.parseDecodable(data: from, decodableType: AuthResponse.self)
        return data.requestToken
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
        url.appendPathComponent("token")
        url.appendPathComponent("new")
        return url
    }
}
