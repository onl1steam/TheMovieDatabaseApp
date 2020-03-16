//
//  NetworkConfiguration.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

enum NetworkConfiguration {
    
    static let baseURL = URL(string: "https://api.themoviedb.org/")!
    static let imageBaseURL = URL(string: "https://image.tmdb.org/")!
    static let apiKey = "591efe0e25fd45c1579562958b2364db"
}
