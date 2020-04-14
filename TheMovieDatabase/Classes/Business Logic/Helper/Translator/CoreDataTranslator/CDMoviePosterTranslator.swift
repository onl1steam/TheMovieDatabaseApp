//
//  CDMoviePosterTranslator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabasePersistence

class CDMoviePosterTranslator {
    
    func fill(_ entry: inout CDMoviePoster, fromEntity: MoviePoster) {
        let cdMoviePoster = CDMoviePoster()
        
        cdMoviePoster.posterPath = fromEntity.posterPath
        cdMoviePoster.image = fromEntity.image
        
        entry = cdMoviePoster
    }
    
    func fill(_ entity: inout MoviePoster, fromEntry: CDMoviePoster) {
        entity = MoviePoster(posterPath: fromEntry.posterPath, image: fromEntry.image)
    }
}
