//
//  AccountResponse.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public struct AccountResponse: Decodable {
    
    public let avatar: Avatar
    public let id: Int
    public let iso6391: String
    public let iso31661: String
    public let name: String
    public let includeAdult: Bool
    public let username: String
    
    public struct Avatar: Decodable {
        public let gravatar: Gravatar
    }
    
    public struct Gravatar: Decodable {
        public let hash: String
    }
}
