//
//  Images.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

enum Images {
    static let favorite = UIImage(named: ImageNames.favorite)!
    static let favoritesBackground = UIImage(named: ImageNames.favoritesBackground)!
    static let arrowBack = UIImage(named: ImageNames.arrowBack)!
    static let account = UIImage(named: ImageNames.account)!
    static let list = UIImage(named: ImageNames.list)!
    static let movie = UIImage(named: ImageNames.movie)!
    static let moviesBackground = UIImage(named: ImageNames.moviesBackground)!
    static let search = UIImage(named: ImageNames.search)!
    static let visibilityNone = UIImage(named: ImageNames.visibilityNone)!
    static let visibility = UIImage(named: ImageNames.visibility)!
    static let widgets = UIImage(named: ImageNames.widgets)!
    static let clearSearchText = UIImage(named: ImageNames.clearSearchText)!
    static let avatar = UIImage(named: ImageNames.avatar)!
    
    enum ImageNames {
        static let favorite = "favorite.png"
        static let favoritesBackground = "favorites_bg.png"
        static let arrowBack = "arrow_back.png"
        static let account = "account.png"
        static let list = "list.png"
        static let movie = "movie.png"
        static let moviesBackground = "movies_bg.png"
        static let search = "search.png"
        static let visibilityNone = "visibility_none.png"
        static let visibility = "visibility.png"
        static let widgets = "widgets.png"
        static let clearSearchText = "clearSearchText.png"
        static let avatar = "avatar.png"
    }
}
