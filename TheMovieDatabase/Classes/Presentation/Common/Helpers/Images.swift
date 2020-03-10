//
//  Images.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

enum Images {
    static let favoritesTabBar = UIImage(named: ImageNames.favoritesTabBar)!
    static let favoritesBackground = UIImage(named: ImageNames.favoritesBackground)!
    
    static let accountTabBar = UIImage(named: ImageNames.accountTabBar)!
    static let avatarPlaceholder = UIImage(named: ImageNames.avatarPlaceholder)!
    
    static let moviesTabBar = UIImage(named: ImageNames.moviesTabBar)!
    static let moviesBackground = UIImage(named: ImageNames.moviesBackground)!
    
    static let visibilityNone = UIImage(named: ImageNames.visibilityNone)!
    static let visibility = UIImage(named: ImageNames.visibility)!
    static let clearSearchText = UIImage(named: ImageNames.clearSearchText)!
    static let search = UIImage(named: ImageNames.search)!
    static let listButton = UIImage(named: ImageNames.listButton)!
    static let widgetsButton = UIImage(named: ImageNames.widgetsButton)!
    static let arrowBack = UIImage(named: ImageNames.arrowBack)!
    
    private enum ImageNames {
        static let favoritesTabBar = "favorite.png"
        static let favoritesBackground = "favorites_bg.png"
        
        static let accountTabBar = "account.png"
        static let avatarPlaceholder = "avatar.png"
        
        static let moviesTabBar = "movie.png"
        static let moviesBackground = "movies_bg.png"
        
        static let visibilityNone = "visibility_none.png"
        static let visibility = "visibility.png"
        static let clearSearchText = "clearSearchText.png"
        static let search = "search.png"
        static let listButton = "list.png"
        static let widgetsButton = "widgets.png"
        static let arrowBack = "arrow_back.png"
    }
}
