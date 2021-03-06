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
    
    public typealias Content = DeleteSessionResponse
    
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
        guard let resultURL = urlComponents.url else { throw NetworkError.badURL }
        
        var request = URLRequest(url: resultURL)
        let encodableData = DeleteSessionBody(sessionId: sessionId)
        let data = try EndpointDefaultMethods.encodeBody(data: encodableData)
        
        request.httpMethod = HttpMethods.DELETE.rawValue
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        request.httpBody = data
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
        let data = try EndpointDefaultMethods.parseDecodable(data: from, decodableType: DeleteSessionResponse.self)
        return data
    }
    
    // MARK: - Private Methods
    
    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("authentication")
        url.appendPathComponent("session")
        return url
    }
}
