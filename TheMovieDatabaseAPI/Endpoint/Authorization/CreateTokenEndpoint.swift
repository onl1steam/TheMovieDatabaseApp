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
    
    let baseURL: URL
    let apiKey: String
    
    // MARK: - Initializers
    
    public init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
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
            let items = try decoder.decode(AuthResponse.self, from: data)
            return items.requestToken
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
        url.appendPathComponent("token")
        url.appendPathComponent("new")
        return url
    }
}
