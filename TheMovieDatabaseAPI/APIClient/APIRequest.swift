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
open class APIRequest: APIClient {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - APIClient
    
    @discardableResult
    public func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void) -> Progress where T: Endpoint {
        
        do {
            let urlRequest = try endpoint.makeRequest()
            AF.request(urlRequest).response { response in
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
        } catch {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
        return Progress()
    }
}
