//
//  DatabaseService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabasePersistence

/// Сервис, загружающий данные из БД
protocol DatabaseServiceType {
    
    /// Сохраняет список фильмов в БД
    ///
    /// - Parameters:
    ///     - entities: Список фильмов, которые необходимо сохранить.
    func saveMovieDetails(_ entities: [MovieDetails])
    
    /// Загружает список фильмов из БД
    func fetchMovieDetails() -> [MovieDetails]
}

/// Сервис, загружающий данные из БД
final class DatabaseService: DatabaseServiceType {
    
    // MARK: - Private Properties
    
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
    
    // MARK: - DatabaseServiceType
    
    func saveMovieDetails(_ entities: [MovieDetails]) {
        saveMoviesToRealm(entities)
    }
    
    func fetchMovieDetails() -> [MovieDetails] {
        let movies = readMoviesFromRealm()
        return movies
    }
    
    // MARK: - Private Methods
    
    private func saveMoviesToRealm(_ entities: [MovieDetails]) {
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
    
    private func readMoviesFromRealm() -> [MovieDetails] {
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
