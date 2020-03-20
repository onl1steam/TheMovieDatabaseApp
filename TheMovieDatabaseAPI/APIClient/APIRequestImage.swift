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
    
    let imageCache = ImageCache()

    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - APIClient
    
    @discardableResult
    public func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void) -> Progress where T: Endpoint {
        do {
            let urlRequest = try endpoint.makeRequest()
            
            if let data = checkImageInCache(url: urlRequest.url?.absoluteString) as? T.Content {
                completionHandler(.success(data))
                return Progress()
            }
            
            let request = AF.request(urlRequest)
            request.response { response in
                do {
                    let content = try endpoint.content(from: response.data, response: response.response)
                    self.saveImageInCache(url: urlRequest.url?.absoluteString, data: response.data)
                    DispatchQueue.main.async {
                        completionHandler(.success(content))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            }
            return request.downloadProgress
        } catch {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
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
