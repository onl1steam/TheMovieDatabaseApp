//
//  DeleteSessionEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для удаления сессии.
public class DeleteSessionEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = Bool
    
    // MARK: - Public Properties
    
    let baseURL: URL
    let apiKey: String
    let sessionId: String

    // MARK: - Initializers
    
    public init(baseURL: URL, apiKey: String, sessionId: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.sessionId = sessionId
    }
    
    // MARK: - Endpoint
 
    public func makeRequest() throws -> URLRequest {
        let queryItems = makeQueryItems()
        let url = makeURLPath()
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else { throw NetworkError.badURL }
        var request = URLRequest(url: resultURL)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        
        let encodableData = DeleteSessionBody(sessionId: sessionId)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        do {
            let data = try encoder.encode(encodableData)
            request.httpBody = data
        } catch {
            throw NetworkError.encodingError
        }
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
            let items = try decoder.decode(DeleteSessionResponse.self, from: data)
            return items.success
        } catch {
            throw error
        }
    }
    
    // MARK: - Private Methods
    
    private func makeQueryItems() -> [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        return queryItems
    }
    
    private func makeURLPath() -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("authentication")
        url.appendPathComponent("session")
        return url
    }
}
