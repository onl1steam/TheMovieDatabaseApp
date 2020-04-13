//
//  CDMovieDetails.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData

@objc(CDMovieDetails)
class CDMovieDetails: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var originalTitle: String
    @NSManaged var overview: String?
    @NSManaged var posterPath: String?
    @NSManaged var releaseDate: String
    @NSManaged var runtime: Int
    @NSManaged var title: String
    @NSManaged var voteAverage: Double
    @NSManaged var voteCount: Int
    @NSManaged var genres: [CDGenres]
}
