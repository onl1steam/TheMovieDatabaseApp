//
//  DatabaseService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabasePersistence

final class DatabaseService {
    
    private var details = MovieDetails(
        genres: [],
        id: 0,
        originalTitle: "",
        overview: nil,
        posterPath: nil,
        releaseDate: "",
        runtime: nil,
        title: "",
        voteAverage: 0,
        voteCount: 0)
    
    func saveMoviesToCD(_ entities: [MovieDetails]) {
        let translator = CDMovieDetailsTranslator()
        var cdMovieDetails = [CoreDataMovieDetails]()
        
        entities.forEach { entity in
            var details = CoreDataMovieDetails()
            translator.fill(&details, fromEntity: entity)
            cdMovieDetails.append(details)
        }
        
        let creator = CDMovieDetailsCreator(entities: cdMovieDetails)

        let cdDatabase = CoreDataDatabase<CDMovieDetails>(creator: creator)
        try? cdDatabase.persist()
    }
    
    func readMoviesFromCD() -> [MovieDetails] {
        let cdDatabase = CoreDataDatabase<CDMovieDetails>(creator: nil)
        let transalor = CDMovieDetailsTranslator()
        var movieDetails = [MovieDetails]()
        
        if let entries = try? cdDatabase.read() {
            entries.forEach { entry in
                transalor.fill(&details, fromEntry: entry)
                movieDetails.append(details)
            }
            return movieDetails
        } else {
            return []
        }
    }
    
    func saveMoviesToRealm(_ entities: [MovieDetails]) {
        let transalor = RLMMovieDetailsTranslator()
        var cdDetails = [RLMMovieDetails]()
        
        entities.forEach { entity in
            var details = RLMMovieDetails()
            transalor.fill(&details, fromEntity: entity)
            cdDetails.append(details)
        }
        
        let realmDB = RealmDatabase<RLMMovieDetails>()
        try? realmDB.persist(cdDetails)
    }
    
    func readMoviesFromRealm() -> [MovieDetails] {
        let realmDB = RealmDatabase<RLMMovieDetails>()
        let transalor = RLMMovieDetailsTranslator()
        var movieDetails = [MovieDetails]()
        
        if let entries = try? realmDB.read() {
            entries.forEach { entry in
                transalor.fill(&details, fromEntry: entry)
                movieDetails.append(details)
            }
            return movieDetails
        } else {
            return []
        }
    }
}
