//
//  MoviesResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 14.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
    
    let page: Int
    let results: [MoviesResult]
    let totalPages: Int
    let totalResults: Int
    
    struct MoviesResult: Decodable {
        let id: Int
    }
}
