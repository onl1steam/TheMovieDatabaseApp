//
//  AuthRequestConfig.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

enum AuthRequestConfig {
    static let apiKey = "591efe0e25fd45c1579562958b2364db"
    static let createTokenURLString = "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)"
    static let createSessionURLString = "https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKey)"
    static let validateSessionURLString = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(apiKey)"
    static let deleteSessionURLString = "https://api.themoviedb.org/3/authentication/session?api_key=\(apiKey)"
}
