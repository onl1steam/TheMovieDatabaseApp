//
//  AvatarEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для получения аватара пользователя.
public struct AvatarEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = Data

    // MARK: - Public Properties
    
    let baseURL: URL
    let imagePath: String
    
    // MARK: - Initializers
    
    public init(baseURL: URL, imagePath: String) {
        self.baseURL = baseURL
        self.imagePath = imagePath
    }
    
    // MARK: - Endpoint
 
    public func makeRequest() throws -> URLRequest {
        let url = makeURLPath()
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
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
        return data
    }
    
    // MARK: - Private Methods
    
    private func makeURLPath() -> URL {
        var url = baseURL
        url.appendPathComponent("avatar")
        url.appendPathComponent(imagePath)
        return url
    }
}
