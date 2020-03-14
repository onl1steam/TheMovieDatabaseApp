//
//  MovieDetailsResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct MovieDetailsResponse: Decodable {
    
    let genres: [Genre]
    let id: Int
    let originalTitle: String
    let overview: String?
    let posterPath: String?
    let releaseDate: String
    let runtime: Int?
    let title: String
    let voteAverage: Double
    let voteCount: Int
    
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
}
