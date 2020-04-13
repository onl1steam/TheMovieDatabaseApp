//
//  RLMMovieDetails.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import RealmSwift

class RLMMovieDetails: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var releaseDate: String = ""
    dynamic var runtime = RealmOptional<Int>()
    @objc dynamic var title: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var voteCount: Int = 0
    
    var genres = List<RLMGenres>()
}
