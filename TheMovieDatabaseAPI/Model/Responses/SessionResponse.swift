//
//  SessionResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct SessionResponse: Decodable {
    
    let sessionId: String
    let success: Bool
}