//
//  CDMovieDetails.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData

@objc(CDMovieDetails)
public class CDMovieDetails: CoreDataEntry {
    
    @NSManaged public var id: Int
    @NSManaged public var originalTitle: String
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String
    @NSManaged public var runtime: Int
    @NSManaged public var title: String
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int
    @NSManaged public var genres: [CDGenres]
    
    @NSManaged public override var entryId: String
}
