//
//  SessionResponse.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct SessionResponse: Decodable {
    var sessionId: String?
    var success: Bool?
    var statusCode: Int?
    var statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case success = "success"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
