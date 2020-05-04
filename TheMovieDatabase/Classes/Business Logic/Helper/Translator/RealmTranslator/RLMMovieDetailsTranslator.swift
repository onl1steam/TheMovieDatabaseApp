//
//  RLMMovieDetailsTranslator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabasePersistence

class RLMMovieDetailsTranslator {
    
    let genresTranslator: RLMGenresTranslator = RLMGenresTranslator()
    
    func fill(_ entry: inout RLMMovieDetails, fromEntity: MovieDetails) {
        let movieDetails = RLMMovieDetails()
        movieDetails.id = fromEntity.id
        movieDetails.originalTitle = fromEntity.originalTitle
        movieDetails.overview = fromEntity.overview
        movieDetails.posterPath = fromEntity.posterPath
        movieDetails.releaseDate = fromEntity.releaseDate
        movieDetails.runtime.value = fromEntity.runtime
        movieDetails.title = fromEntity.title
        movieDetails.voteAverage = fromEntity.voteAverage
        movieDetails.voteCount = fromEntity.voteCount
        
        var rlmGenres = [RLMGenres]()
        genresTranslator.fill(&rlmGenres, fromEntities: fromEntity.genres)
        movieDetails.genres.append(objectsIn: rlmGenres)
        
        entry = movieDetails
    }
    
    func fill(_ entity: inout MovieDetails, fromEntry: RLMMovieDetails) {
        var genres = [MovieDetails.Genre]()
        let genresArray = Array(fromEntry.genres)
        genresTranslator.fill(&genres, fromEntries: genresArray)
        
        let movieDetails = MovieDetails(
            genres: genres,
            id: fromEntry.id,
            originalTitle: fromEntry.originalTitle,
            overview: fromEntry.overview,
            posterPath: fromEntry.posterPath,
            releaseDate: fromEntry.releaseDate,
            runtime: fromEntry.runtime.value,
            title: fromEntry.title,
            voteAverage: fromEntry.voteAverage,
            voteCount: fromEntry.voteCount)

        entity = movieDetails
    }
}
