//
//  AccountResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 14.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct AccountResponse: Decodable {
    
    let avatar: Avatar
    let id: Int
    let iso6391: String
    let iso31661: String
    let name: String
    let includeAdult: Bool
    let username: String
    
    struct Avatar: Decodable {
        let gravatar: Gravatar
    }
    
    struct Gravatar: Decodable {
        let hash: String
    }
}
