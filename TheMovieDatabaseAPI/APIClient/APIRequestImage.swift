//
//  APIRequestImage.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Alamofire
import Foundation

open class APIRequestImage: APIClient {
    
    public init() {}
    
    let imageCache = ImageCache.shared
    
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
    
    private func checkImageInCache(url: String?) -> Data? {
        guard let url = url,
            let data = imageCache.checkImageInCache(key: url) else { return nil }
        return data
    }
}
