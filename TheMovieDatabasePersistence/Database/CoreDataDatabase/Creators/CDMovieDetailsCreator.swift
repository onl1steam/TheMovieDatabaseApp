//
//  CDMovieDetailsCreator.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData
import Foundation

public class CDMovieDetailsCreator: CDInstanceCreator {
    
    private var movieDetails = [CoreDataMovieDetails]()
    
    public init(entities: [CoreDataMovieDetails]) {
        movieDetails = entities
    }
    
    public func createInstances(context: NSManagedObjectContext) {
        movieDetails.forEach { details in
            guard var cdEntry = NSEntityDescription.insertNewObject(
                forEntityName: CDMovieDetails.entryName,
                into: context) as? CDMovieDetails else { return }
            fill(&cdEntry, entity: details)
        }
    }
    
    private func fill(_ entry: inout CDMovieDetails, entity: CoreDataMovieDetails) {
        entry.id = entity.id
        entry.originalTitle = entity.originalTitle
        entry.overview = entity.overview
        entry.posterPath = entity.posterPath
        entry.releaseDate = entity.releaseDate
        if let runtime = entity.runtime {
            entry.runtime = runtime
        } else {
            entry.runtime = -1
        }
        entry.title = entity.title
        entry.voteAverage = entity.voteAverage
        entry.voteCount = entity.voteCount
        
        entry.entryId = "\(entry.id)"
        
        var cdGenres = [CDGenres]()
        entity.genres.forEach { genre in
            let cdGenre = CDGenres()
            cdGenre.id = genre.id
            cdGenre.name = genre.name
            cdGenre.entryId = "\(genre.id)"
            cdGenres.append(cdGenre)
        }
        
        entry.genres = cdGenres
    }
}
