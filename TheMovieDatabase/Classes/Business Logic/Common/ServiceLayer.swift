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
    
    let authService: Authorization
    let sessionService: Session
    let imageService: ImageServiceType
    let moviesService: MoviesServiceType
    let validationService: Validation = ValidationService()
    
    // MARK: - Private Properties
    
    private let configuration: Configuration
    private let apiClient: APIClient
    private let apiImageClient: APIClient
    
    // MARK: - Initializers
    
    private init() {
        configuration = Configuration(
            baseURL: NetworkConfiguration.baseURL,
            basePosterURL: NetworkConfiguration.imageBaseURL,
            baseAvatarURL: NetworkConfiguration.avatarBaseURL,
            apiKey: NetworkConfiguration.apiKey)
        
        apiClient = APIRequest(configuration: configuration)
        apiImageClient = APIRequestImage(configuration: configuration)
        
        authService = AuthService(apiClient: apiClient)
        sessionService = SessionService(apiClient: apiClient)
        imageService = ImageService(imageApiClient: apiImageClient)
        moviesService = MoviesService(apiClient: apiClient)
    }
}
