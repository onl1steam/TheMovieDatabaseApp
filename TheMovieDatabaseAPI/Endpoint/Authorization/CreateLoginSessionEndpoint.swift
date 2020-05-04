//
//  CreateLoginSessionEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для валидации и создания сессии с логином и паролем.
public struct CreateLoginSessionEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = AuthResponse
    
    // MARK: - Public Properties
    
    let username: String
    let password: String
    let requestToken: String
    
    // MARK: - Initializers
    
    public init(username: String, password: String, requestToken: String) {
        self.username = username
        self.password = password
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
        let encodableData = CreateLoginSessionBody(username: username, password: password, requestToken: requestToken)
        let data = try EndpointDefaultMethods.encodeBody(data: encodableData)
        
        request.httpMethod = HttpMethods.POST.rawValue
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        request.httpBody = data
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
        let data = try EndpointDefaultMethods.parseDecodable(data: from, decodableType: AuthResponse.self)
        return data
    }
    
    // MARK: - Private Methods
    
    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("authentication")
        url.appendPathComponent("token")
        url.appendPathComponent("validate_with_login")
        return url
    }
}
