//
//  APIClient.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 14.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Alamofire
import Foundation

public protocol APIClient: AnyObject {
    
    @discardableResult
    func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void
    ) -> Progress where T: Endpoint
}

open class APIRequest: APIClient {
    
    public init() {}
    
    @discardableResult
    public func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void) -> Progress where T: Endpoint {
        
        do {
            let urlRequest = try endpoint.makeRequest()
            AF.request(urlRequest).response { response in
                do {
                    let content = try endpoint.content(from: response.data, response: response.response)
                    completionHandler(.success(content))
                } catch let error {
                    completionHandler(.failure(error))
                }
            }
        } catch let error {
            completionHandler(.failure(error))
        }
        return Progress()
    }
}
