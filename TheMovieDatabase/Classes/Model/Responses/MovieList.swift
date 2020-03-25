//
//  MovieList.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabaseAPI

struct MovieList {
    
    let page: Int
    let results: [MoviesResult]
    let totalPages: Int
    let totalResults: Int
    
    struct MoviesResult {
        let id: Int
    }
    
    init(moviesResponse: MoviesResponse) {
        var resultArray = [MoviesResult]()
        moviesResponse.results.forEach { result in
            let resultValue = MoviesResult(id: result.id)
            resultArray.append(resultValue)
        }
        results = resultArray
        
        page = moviesResponse.page
        totalPages = moviesResponse.totalPages
        totalResults = moviesResponse.totalResults
    }
    
    init(page: Int, results: [MovieList.MoviesResult], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
