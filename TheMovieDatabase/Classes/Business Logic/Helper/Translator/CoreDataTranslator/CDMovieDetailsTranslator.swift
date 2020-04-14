//
//  CDMovieDetailsTranslator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabasePersistence

class CDMovieDetailsTranslator {
    
    let genresTranslator: CDGenresTranslator = CDGenresTranslator()
    
    func fill(_ entry: inout CDMovieDetails, fromEntity: MovieDetails) {
        let movieDetails = CDMovieDetails()
        movieDetails.id = fromEntity.id
        movieDetails.originalTitle = fromEntity.originalTitle
        movieDetails.overview = fromEntity.overview
        movieDetails.posterPath = fromEntity.posterPath
        movieDetails.releaseDate = fromEntity.releaseDate
        movieDetails.runtime = setupCDRuntime(fromEntity.runtime)
        movieDetails.title = fromEntity.title
        movieDetails.voteAverage = fromEntity.voteAverage
        movieDetails.voteCount = fromEntity.voteCount
        
        var cdGenres = [CDGenres]()
        genresTranslator.fill(&cdGenres, fromEntities: fromEntity.genres)
        movieDetails.genres.append(contentsOf: cdGenres)
        
        entry = movieDetails
    }
    
    func fill(_ entity: inout MovieDetails, fromEntry: CDMovieDetails) {
        var genres = [MovieDetails.Genre]()
        genresTranslator.fill(&genres, fromEntries: fromEntry.genres)
        
        let runtime = setupAppRuntime(fromEntry.runtime)
        
        let movieDetails = MovieDetails(
            genres: genres,
            id: fromEntry.id,
            originalTitle: fromEntry.originalTitle,
            overview: fromEntry.overview,
            posterPath: fromEntry.posterPath,
            releaseDate: fromEntry.releaseDate,
            runtime: runtime,
            title: fromEntry.title,
            voteAverage: fromEntry.voteAverage,
            voteCount: fromEntry.voteCount)

        entity = movieDetails
    }
    
    private func setupCDRuntime(_ runtime: Int?) -> Int {
        if let runtime = runtime {
            return runtime
        } else {
            return -1
        }
    }
    
    private func setupAppRuntime(_ runtime: Int) -> Int? {
        let appRuntime = (runtime != -1) ? runtime: nil
        return appRuntime
    }
}
