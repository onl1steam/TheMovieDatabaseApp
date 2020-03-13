//
//  ServiceLayer.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

class ServiceLayer {
    
    // MARK: - Public Properties
    
    static let shared = ServiceLayer()
    
    let authService: Authorization = AuthService()
    let sessionService: Session = SessionService()
    
    // MARK: - Initializers
    
    private init() {}
}
