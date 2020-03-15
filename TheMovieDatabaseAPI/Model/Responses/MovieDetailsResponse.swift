//
//  MovieDetailsResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public struct MovieDetailsResponse: Decodable {
    
    public let genres: [Genre]
    public let id: Int
    public let originalTitle: String
    public let overview: String?
    public let posterPath: String?
    public let releaseDate: String
    public let runtime: Int?
    public let title: String
    public let voteAverage: Double
    public let voteCount: Int
    
    public struct Genre: Decodable {
        public let id: Int
        public let name: String
    }
}
