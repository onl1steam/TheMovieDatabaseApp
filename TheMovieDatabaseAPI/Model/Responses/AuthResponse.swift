//
//  AuthResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public struct AuthResponse: Decodable {
    
    let success: Bool
    let expiresAt: String
    let requestToken: String
}
