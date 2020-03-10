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
    
    static let favorite = UIImage(named: ImageNames.favorite)!
    static let favoriteFilled = UIImage(named: ImageNames.favoriteFilled)!
    static let visibilityNone = UIImage(named: ImageNames.visibilityNone)!
    static let visibility = UIImage(named: ImageNames.visibility)!
    static let clearSearchText = UIImage(named: ImageNames.clearSearchText)!
    static let search = UIImage(named: ImageNames.search)!
    static let listButton = UIImage(named: ImageNames.listButton)!
    static let widgetsButton = UIImage(named: ImageNames.widgetsButton)!
    static let arrowBack = UIImage(named: ImageNames.arrowBack)!
    
    private enum ImageNames {
        static let favoritesTabBar = "favorite_tab_bar"
        static let favoritesBackground = "favorites_bg"
        
        static let accountTabBar = "account_tab_bar"
        static let avatarPlaceholder = "avatar"
        
        static let moviesTabBar = "movie_tab_bar"
        static let moviesBackground = "movies_bg"
        
        static let favorite = "favorite"
        static let favoriteFilled = "favorite_filled"
        static let visibilityNone = "visibility_none"
        static let visibility = "visibility"
        static let clearSearchText = "clearSearchText"
        static let search = "search"
        static let listButton = "list"
        static let widgetsButton = "widgets"
        static let arrowBack = "arrow_back"
    }
}
