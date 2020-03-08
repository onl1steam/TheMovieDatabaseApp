//
//  ServiceLayer.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

class ServiceLayer {
    static let shared = ServiceLayer()
    
    private init() {}
    
    let authService: Authorization = AuthService()
}
