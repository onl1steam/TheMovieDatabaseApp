//
//  MoviesResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public struct MoviesResponse: Decodable {
    
    public let page: Int
    public let results: [MoviesResult]
    public let totalPages: Int
    public let totalResults: Int
    
    public struct MoviesResult: Decodable {
        public let id: Int
    }
}
