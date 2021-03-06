//
//  SessionResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public struct SessionResponse: Decodable {
    
    public let sessionId: String
    public let success: Bool
}
