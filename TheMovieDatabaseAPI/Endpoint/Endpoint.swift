//
//  Endpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 14.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public protocol Endpoint {
    
    associatedtype Content
    
    func makeRequest() throws -> URLRequest
    
    func content(from: Data?, response: URLResponse?) throws -> Content
}
