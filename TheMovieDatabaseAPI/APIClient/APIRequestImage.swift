//
//  APIRequestImage.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Alamofire
import Foundation

/// Запрос на полученние изображений из базы данных фильмов.
public final class APIRequestImage: APIClient {
    
    // MARK: - Public Properties
    
    let session = Session(configuration: .ephemeral)
    let imageCache = ImageCache()
    let configuration: Configuration
    
    // MARK: - Initializers
    
    public init(configuration: Configuration) {
        self.configuration = configuration
    }
    // MARK: - APIClient
    
    @discardableResult
    public func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void) -> Progress where T: Endpoint {
        do {
            var customEndpoint = endpoint
            customEndpoint.configuration = configuration
            let urlRequest = try customEndpoint.makeRequest()
            
            if let data = checkImageInCache(url: urlRequest.url?.absoluteString) as? T.Content {
                completionHandler(.success(data))
                return Progress()
            }
            
            let request = session.request(urlRequest)
            request.response(queue: .main) { [weak self] response in
                let result = Result { () -> T.Content in
                    let content = try endpoint.content(from: response.data, response: response.response)
                    self?.saveImageInCache(url: urlRequest.url?.absoluteString, data: response.data)
                    return content
                }
                completionHandler(result)
            }
            return request.downloadProgress
        } catch {
            completionHandler(.failure(error))
            return Progress()
        }
    }
    
    // MARK: - Private Methods
    
    private func checkImageInCache(url: String?) -> Data? {
        guard let url = url,
            let data = imageCache.checkImageInCache(key: url) else { return nil }
        return data
    }
    
    private func saveImageInCache(url: String?, data: Data?) {
        guard let url = url, let data = data else { return }
        imageCache.cacheImage(key: url, imageData: data)
    }
    
}
