//
//  RLMMovieDetails.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import RealmSwift

/// Модель Realm информации о фильмах
public class RLMMovieDetails: RealmEntry {
    
    @objc public dynamic var id: Int = 0
    @objc public dynamic var originalTitle: String = ""
    @objc public dynamic var overview: String?
    @objc public dynamic var posterPath: String?
    @objc public dynamic var releaseDate: String = ""
    public dynamic var runtime = RealmOptional<Int>()
    @objc public dynamic var title: String = ""
    @objc public dynamic var voteAverage: Double = 0
    @objc public dynamic var voteCount: Int = 0
    
    public var genres = List<RLMGenres>()
    
    public override class func primaryKey() -> String? {
        let primaryKey = "id"
        return primaryKey
    }
}
