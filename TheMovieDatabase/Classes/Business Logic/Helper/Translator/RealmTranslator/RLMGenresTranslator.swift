//
//  RLMGenresTranslator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabasePersistence

class RLMGenresTranslator {
    
    func fill(_ entry: inout RLMGenres, fromEntity: MovieDetails.Genre) {
        let rlmGenre = RLMGenres()
        
        rlmGenre.id = fromEntity.id
        rlmGenre.name = fromEntity.name
        
        entry = rlmGenre
    }
    
    func fill(_ entity: inout MovieDetails.Genre, fromEntry: RLMGenres) {
        entity = MovieDetails.Genre(id: fromEntry.id, name: fromEntry.name)
    }
    
    func fill(_ entries: inout [RLMGenres], fromEntities: [MovieDetails.Genre]) {
        var movieGenres = [RLMGenres]()
        
        fromEntities.forEach { genre in
            let entry = RLMGenres()
            entry.id = genre.id
            entry.name = genre.name
            movieGenres.append(entry)
        }
        
        entries = movieGenres
    }
    
    func fill(_ entities: inout [MovieDetails.Genre], fromEntries: [RLMGenres]) {
        var movieGenres = [MovieDetails.Genre]()
        
        fromEntries.forEach { genre in
            let entity = MovieDetails.Genre(id: genre.id, name: genre.name)
            movieGenres.append(entity)
        }
        
        entities = movieGenres
    }
}
