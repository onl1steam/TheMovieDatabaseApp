//
//  CreateSessionEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для создания сессии.
public struct CreateSessionEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = SessionResponse
    
    // MARK: - Public Properties
    
    let requestToken: String
    
    // MARK: - Initializers
    
    public init(requestToken: String) {
        self.requestToken = requestToken
    }
    
    // MARK: - Endpoint
 
    public func makeRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        guard let componentsUrl = urlComponents.url else { throw NetworkError.badURL }
        
        let urlPath = makeURLPath(baseURL: componentsUrl)
        urlComponents.path = urlPath.absoluteString
        guard let resultURL = urlComponents.url else { throw NetworkError.badURL }
        
        var request = URLRequest(url: resultURL)
        let encodableData = CreateSessionBody(requestToken: requestToken)
        let data = try EndpointDefaultMethods.encodeBody(data: encodableData)
        
        request.httpMethod = HttpMethods.POST.rawValue
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        request.httpBody = data
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
        let data = try EndpointDefaultMethods.parseDecodable(data: from, decodableType: SessionResponse.self)
        return data
    }
    
    // MARK: - Private Methods

    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("authentication")
        url.appendPathComponent("session")
        url.appendPathComponent("new")
        return url
    }
}
