//
//  CreateSessionEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public class CreateSessionEndpoint: Endpoint {
    
    public typealias Content = String
    
    let baseURL: URL
    let apiKey: String
    let requestToken: String
    
    public init(baseURL: URL, apiKey: String, requestToken: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.requestToken = requestToken
    }
 
    public func makeRequest() throws -> URLRequest {
        let queryItems = makeQueryItems()
        let url = makeURLPath()
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else { throw NetworkError.badURL }
        var request = URLRequest(url: resultURL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["content-type": "application/json"]
        
        let encodableData = CreateSessionBody(requestToken: requestToken)
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
            let items = try decoder.decode(SessionResponse.self, from: data)
            return items.sessionId
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func makeQueryItems() -> [URLQueryItem] {
        let query = URLQueryItem(name: "api_key", value: apiKey)
        var queryItems = [URLQueryItem]()
        queryItems.append(query)
        return queryItems
    }
    
    func makeURLPath() -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("authentication")
        url.appendPathComponent("session")
        url.appendPathComponent("new")
        return url
    }
}