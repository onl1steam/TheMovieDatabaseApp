//
//  RLMMoviePosterTranslator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabasePersistence

class RLMMoviePosterTranslator {
    
    func fill(_ entry: inout RLMMoviePoster, fromEntity: MoviePoster) {
        let rlmMoviePoster = RLMMoviePoster()
        
        rlmMoviePoster.posterPath = fromEntity.posterPath
        rlmMoviePoster.image = fromEntity.image
        
        entry = rlmMoviePoster
    }
    
    func fill(_ entity: inout MoviePoster, fromEntry: RLMMoviePoster) {
        entity = MoviePoster(posterPath: fromEntry.posterPath, image: fromEntry.image)
    }
}
