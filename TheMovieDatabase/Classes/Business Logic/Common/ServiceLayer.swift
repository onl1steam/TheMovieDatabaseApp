//
//  ServiceLayer.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

/// Предоставляет все сервисы слоя бизнес логики.
final class ServiceLayer {
    
    // MARK: - Public Properties
    
    static let shared = ServiceLayer()

    let configuration: Configuration
    
    let apiRequest: APIClient
    let apiRequestImage: APIClient
    
    let authService: Authorization
    let sessionService: Session
    let imageService: ImageServiceType
    let moviesService: MoviesServiceType
    
    // MARK: - Initializers
    
    private init() {
        configuration = Configuration(
            baseURL: NetworkConfiguration.baseURL,
            basePosterURL: NetworkConfiguration.imageBaseURL,
            baseAvatarURL: NetworkConfiguration.avatarBaseURL,
            apiKey: NetworkConfiguration.apiKey)
        
        apiRequest = APIRequest(configuration: configuration)
        apiRequestImage = APIRequestImage(configuration: configuration)
        
        authService = AuthService(apiClient: apiRequest)
        sessionService = SessionService(apiClient: apiRequest)
        imageService = ImageService(imageApiClient: apiRequestImage)
        moviesService = MoviesService(apiClient: apiRequest)
    }
}
