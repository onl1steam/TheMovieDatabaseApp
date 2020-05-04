//
//  AccountDetails.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

struct AccountDetails {
    
    let avatar: Avatar
    let id: Int
    let iso6391: String
    let iso31661: String
    let name: String
    let includeAdult: Bool
    let username: String
    
    struct Avatar {
        let gravatar: Gravatar
    }
    
    struct Gravatar {
        let hash: String
    }
    
    init(accountResponse: AccountResponse) {
        let hash = accountResponse.avatar.gravatar.hash
        avatar = Avatar(gravatar: Gravatar(hash: hash))
        id = accountResponse.id
        iso6391 = accountResponse.iso6391
        iso31661 = accountResponse.iso31661
        name = accountResponse.name
        includeAdult = accountResponse.includeAdult
        username = accountResponse.username
    }
    
    init(
        avatar: AccountDetails.Avatar,
        id: Int,
        iso6391: String,
        iso31661: String,
        name: String,
        includeAdult: Bool,
        username: String) {
        self.avatar = avatar
        self.id = id
        self.iso6391 = iso6391
        self.iso31661 = iso31661
        self.name = name
        self.includeAdult = includeAdult
        self.username = username
    }
}
