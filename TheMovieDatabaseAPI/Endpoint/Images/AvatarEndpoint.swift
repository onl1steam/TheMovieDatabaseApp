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

    let imagePath: String
    
    public var configuration: Configuration?
    
    // MARK: - Initializers
    
    public init(imagePath: String) {
        self.imagePath = imagePath
    }
    
    // MARK: - Endpoint
 
    public func makeRequest() throws -> URLRequest {
        guard let configuration = configuration else { throw NetworkError.noConfiguration }
        
        let url = makeURLPath(baseURL: configuration.baseAvatarURL)
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        guard let resultURL = urlComponents?.url else { throw NetworkError.badURL }
        var request = URLRequest(url: resultURL)
        request.httpMethod = HttpMethods.GET.rawValue
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
        guard let data = from else { throw NetworkError.blankData }
        return data
    }
    
    // MARK: - Private Methods
    
    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("avatar")
        url.appendPathComponent(imagePath)
        return url
    }
}
