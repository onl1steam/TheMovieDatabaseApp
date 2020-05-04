//
//  MarkFavoriteBody.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 07.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

struct MarkFavoriteBody: Encodable {

    let mediaType: String
    let mediaId: Int
    let favorite: Bool
}
