//
//  AccountDetailsEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для получения детальной информации об аккаунте.
public struct AccountDetailsEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = AccountResponse
    
    // MARK: - Public Properties
    
    let sessionId: String
    
    // MARK: - Initializers
    
    public init(sessionId: String) {
        self.sessionId = sessionId
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
        let query = [URLQueryItem(name: "session_id", value: sessionId)]
        return query
    }
    
    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("account")
        return url
    }
}
