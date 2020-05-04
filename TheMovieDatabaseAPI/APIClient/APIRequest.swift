//
//  APIRequest.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Alamofire
import Foundation

/// Запрос на полученние данных из базы данных фильмов.
public final class APIRequest: APIClient {
    
    // MARK: - Public Properties
    
    let session = Session(configuration: .ephemeral)
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
            
            let request = session.request(resultUrlRequest)
            request.response(queue: .main) { response in
                let result = Result { () -> T.Content in
                    let content = try endpoint.content(from: response.data, response: response.response)
                    return content
                }
                completionHandler(result)
            }
            let progress = Progress()
            progress.cancellationHandler = { request.cancel() }
            return progress
        } catch {
            completionHandler(.failure(error))
        }
        return Progress()
    }
}
