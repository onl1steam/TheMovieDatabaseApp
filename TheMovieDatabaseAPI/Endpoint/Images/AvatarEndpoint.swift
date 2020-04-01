//
//  AvatarEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Эндпоинт для получения аватара пользователя.
public struct AvatarEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = UIImage

    // MARK: - Public Properties

    let imagePath: String
    
    // MARK: - Initializers
    
    public init(imagePath: String) {
        self.imagePath = imagePath
    }
    
    // MARK: - Endpoint
 
    public func makeRequest() throws -> URLRequest {
        let urlComponents = URLComponents()
        guard let componentsUrl = urlComponents.url else { throw NetworkError.badURL }
        
        let resultURL = makeURLPath(baseURL: componentsUrl)
        
        var request = URLRequest(url: resultURL)
        request.httpMethod = HttpMethods.GET.rawValue
        
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        try EndpointDefaultMethods.checkErrors(data: from, response: response)
        guard let data = from, let image = UIImage(data: data) else { throw NetworkError.blankData }
        return image
    }
    
    // MARK: - Private Methods
    
    private func makeURLPath(baseURL: URL) -> URL {
        var url = baseURL
        url.appendPathComponent("avatar")
        url.appendPathComponent(imagePath)
        return url
    }
}
