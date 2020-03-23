//
//  NetworkSettings.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 18.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

enum NetworkSettings {
    
    static let baseURL = URL(string: "https://api.themoviedb.org/")!
    static let imageBaseURL = URL(string: "https://image.tmdb.org/")!
    static let avatarBaseURL = URL(string: "https://www.gravatar.com/")!
    static let apiKey = "591efe0e25fd45c1579562958b2364db"
    
    static let configuration = Configuration(
        baseURL: baseURL,
        basePosterURL: imageBaseURL,
        baseAvatarURL: imageBaseURL,
        apiKey: apiKey)
    
    static let apiClient: APIClient = APIRequest(configuration: configuration)
    static let imageClient: APIClient = APIRequestImage(configuration: configuration)
}
