//
//  ImageEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Эндпоинт для получения изображения постера фильма.
public struct ImageEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Content = Data
    
    // MARK: - Public Properties
    
    let imageCache = ImageCache.shared
    let baseURL: URL
    let width: String?
    let imagePath: String
    
    // MARK: - Initializers
    
    public init(baseURL: URL, width: String?, imagePath: String) {
        self.baseURL = baseURL
        self.width = width
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
        guard let url = response?.url?.absoluteString,
            let data = from else { throw NetworkError.blankData }
        imageCache.cacheImage(key: url, imageData: data)
        return data
    }
    
    // MARK: - Private Methods
    
    private func makeURLPath() -> URL {
        var url = baseURL
        url.appendPathComponent("t")
        url.appendPathComponent("p")
        if let imageWidth = width {
            url.appendPathComponent(imageWidth)
        } else {
            url.appendPathComponent("original")
        }
        url.appendPathComponent(imagePath)
        return url
    }
}
