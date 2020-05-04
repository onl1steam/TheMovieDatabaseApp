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
            
            let request = session.request(urlRequest)
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
