//
//  ServiceLayer.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Предоставляет все сервисы слоя бизнес логики.
final class ServiceLayer {
    
    // MARK: - Public Properties
    
    static let shared = ServiceLayer()
    
    let authService: Authorization = AuthService()
    let sessionService: Session = SessionService()
    let imageService: ImageServiceType = ImageService()
    let moviesService: MoviesServiceType = MoviesService()
    
    // MARK: - Initializers
    
    private init() {}
}
