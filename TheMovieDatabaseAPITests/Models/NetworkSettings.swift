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
    static let apiKey = "591efe0e25fd45c1579562958b2364db"
    static let apiClient: APIClient = APIRequest()
}
