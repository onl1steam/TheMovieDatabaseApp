//
//  APIClientStub.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 27.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabaseAPI

final class APIClientStub: APIClient {
    
    let responseStub: Any?
    let errorStub: Error?
    
    init(responseStub: Any?, errorStub: Error?) {
        self.responseStub = responseStub
        self.errorStub = errorStub
    }
    
    func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void) -> Progress where T: Endpoint {
        
        if let stub = responseStub {
            completionHandler(.success(stub as! T.Content))
        }
        if let error = errorStub {
            completionHandler(.failure(error))
        }
        return Progress()
    }
}
