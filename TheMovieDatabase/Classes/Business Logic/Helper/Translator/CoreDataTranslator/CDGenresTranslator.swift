//
//  CDGenresTranslator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabasePersistence

class CDGenresTranslator {
    
    func fill(_ entry: inout CoreDataGenres, fromEntity: MovieDetails.Genre) {
        var cdGenre = CoreDataGenres()
        
        cdGenre.id = fromEntity.id
        cdGenre.name = fromEntity.name
        
        entry = cdGenre
    }
    
    func fill(_ entity: inout MovieDetails.Genre, fromEntry: CDGenres) {
        entity = MovieDetails.Genre(id: fromEntry.id, name: fromEntry.name)
    }
    
    func fill(_ entries: inout [CoreDataGenres], fromEntities: [MovieDetails.Genre]) {
        var movieGenres = [CoreDataGenres]()
        
        fromEntities.forEach { genre in
            var entry = CoreDataGenres()
            entry.id = genre.id
            entry.name = genre.name
            movieGenres.append(entry)
        }
        
        entries = movieGenres
    }
    
    func fill(_ entities: inout [MovieDetails.Genre], fromEntries: [CDGenres]) {
        var movieGenres = [MovieDetails.Genre]()
        
        fromEntries.forEach { genre in
            let entity = MovieDetails.Genre(id: genre.id, name: genre.name)
            movieGenres.append(entity)
        }
        
        entities = movieGenres
    }
}
