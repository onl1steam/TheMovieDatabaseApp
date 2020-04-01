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
   let requestAdapter: APIRequestAdapter
    
    // MARK: - Initializers
    
    public init(configuration: Configuration) {
        self.requestAdapter = APIRequestAdapter(configuration: configuration)
    }
    
    // MARK: - APIClient
    
    @discardableResult
    public func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void) -> Progress where T: Endpoint {
        do {
            let urlRequest = try endpoint.makeRequest()
            
            var resultUrlRequest = urlRequest
            requestAdapter.adapt(urlRequest, for: session) { response in
                switch response {
                case .success(let request):
                    resultUrlRequest = request
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
            
            if let data = checkImageInCache(url: resultUrlRequest.url?.absoluteString) as? T.Content {
                completionHandler(.success(data))
                return Progress()
            }
            
            let request = session.request(resultUrlRequest)
            request.response(queue: .main) { [weak self] response in
                let result = Result { () -> T.Content in
                    let content = try endpoint.content(from: response.data, response: response.response)
                    let image = content as? UIImage
                    self?.saveImageInCache(url: urlRequest.url?.absoluteString, image: image)
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
    
    private func checkImageInCache(url: String?) -> UIImage? {
        guard let url = url,
            let image = imageCache.checkImageInCache(key: url) else { return nil }
        return image
    }
    
    private func saveImageInCache(url: String?, image: UIImage?) {
        guard let url = url, let image = image else { return }
        imageCache.cacheImage(key: url, image: image)
    }
    
}
