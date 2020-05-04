//
//  MovieDetails.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabaseAPI

struct MovieDetails {
    
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
    
    struct Genre {
        let id: Int
        let name: String
    }
    
    init(movieDetailsResponse: MovieDetailsResponse) {
        var genresArray = [Genre]()
        movieDetailsResponse.genres.forEach { genre in
            let genreValue = Genre(id: genre.id, name: genre.name)
            genresArray.append(genreValue)
        }
        genres = genresArray
        
        id = movieDetailsResponse.id
        originalTitle = movieDetailsResponse.originalTitle
        overview = movieDetailsResponse.overview
        posterPath = movieDetailsResponse.posterPath
        releaseDate = movieDetailsResponse.releaseDate
        runtime = movieDetailsResponse.runtime
        title = movieDetailsResponse.title
        voteAverage = movieDetailsResponse.voteAverage
        voteCount = movieDetailsResponse.voteCount
    }
    
    init(
        genres: [MovieDetails.Genre],
        id: Int,
        originalTitle: String,
        overview: String?,
        posterPath: String?,
        releaseDate: String,
        runtime: Int?,
        title: String,
        voteAverage: Double,
        voteCount: Int) {
        self.genres = genres
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
