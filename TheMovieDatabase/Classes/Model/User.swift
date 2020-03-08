//
//  User.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct User {
    var login: String
    var password: String
    
    init() {
        login = ""
        password = ""
    }
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
