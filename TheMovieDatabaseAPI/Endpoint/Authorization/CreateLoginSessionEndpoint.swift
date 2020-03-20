//
//  CreateLoginSessionEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для валидации и создания сессии с логином и паролем.
public class CreateLoginSessionEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = String
    
    // MARK: - Public Properties
    
    let baseURL: URL
    let apiKey: String
    let username: String
    let password: String
    let requestToken: String
    
    // MARK: - Initializers
    
    public init(baseURL: URL, apiKey: String, username: String, password: String, requestToken: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.username = username
        self.password = password
        self.requestToken = requestToken
    }
    
    // MARK: - Endpoint
    
    public func makeRequest() throws -> URLRequest {
        let queryItems = makeQueryItems()
        let url = makeURLPath()
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else { throw NetworkError.badURL }
        var request = URLRequest(url: resultURL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        
        let encodableData = CreateLoginSessionBody(username: username, password: password, requestToken: requestToken)
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
        url.appendPathComponent("validate_with_login")
        return url
    }
}
