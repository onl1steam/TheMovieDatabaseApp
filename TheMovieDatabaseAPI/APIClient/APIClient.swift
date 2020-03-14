//
//  APIClient.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 14.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

protocol APIClient: AnyObject {
    
    @discardableResult
    func request<T>(
        _ endpoint: T,
        completionHandler: @escaping (Result<T.Content, Error>) -> Void
    ) -> Progress where T: Endpoint
}
