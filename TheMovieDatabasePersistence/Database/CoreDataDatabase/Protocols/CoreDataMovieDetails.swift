//
//  CoreDataMovieDetails.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public struct CoreDataMovieDetails {
    
    public init() {
        id = 0
        originalTitle = ""
        overview = nil
        posterPath = nil
        releaseDate = ""
        runtime = nil
        title = ""
        voteAverage = 0
        voteCount = 0
        genres = []
    }
    
    public var id: Int
    public var originalTitle: String
    public var overview: String?
    public var posterPath: String?
    public var releaseDate: String
    public var runtime: Int?
    public var title: String
    public var voteAverage: Double
    public var voteCount: Int
    public var genres: [CoreDataGenres]
}
