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
        let request = URLRequest(url: resultURL)
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        guard let resp = response as? HTTPURLResponse else { throw NetworkError.unknownError }
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
            let item = try decoder.decode(AccountResponse.self, from: data)
            return item
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Private Methods
    
    private func makeQueryItems() -> [URLQueryItem] {
        let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        let sessionIdQuery = URLQueryItem(name: "session_id", value: sessionId)
        var queryItems = [URLQueryItem]()
        queryItems.append(apiKeyQuery)
        queryItems.append(sessionIdQuery)
        return queryItems
    }
    
    private func makeURLPath() -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("account")
        return url
    }
}
