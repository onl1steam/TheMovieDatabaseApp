//
//  DeleteSessionResponse.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct DeleteSessionResponse: Decodable {
    
    var success: Bool?
    var statusCode: Int?
    var statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode
        case statusMessage
    }
}
