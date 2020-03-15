//
//  CreateLoginSessionBody.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 15.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct CreateLoginSessionBody: Encodable {
    
    let username: String
    let password: String
    let requestToken: String
}
