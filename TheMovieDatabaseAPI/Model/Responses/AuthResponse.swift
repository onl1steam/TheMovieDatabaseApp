//
//  TokenRequest.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct AuthResponse: Decodable {
    
    let success: Bool
    let expiresAt: String
    let requestToken: String
}
