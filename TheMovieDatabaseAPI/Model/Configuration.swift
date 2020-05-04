//
//  Configuration.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 21.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Настройки подключения к базе данных фильмов.
public class Configuration {
    
    /// BaseURL для поиска по базе данных.
    public let baseURL: URL
    
    /// BaseURL для загрузки постеров к фильму.
    public let basePosterURL: URL
    
    /// BaseURL для загрузки аватара с сервиса Gravatar.
    public let baseAvatarURL: URL
    
    /// APIKey для подключения к базе данных.
    public let apiKey: String
    
    public init(baseURL: URL, basePosterURL: URL, baseAvatarURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.basePosterURL = basePosterURL
        self.baseAvatarURL = baseAvatarURL
        self.apiKey = apiKey
    }
}
