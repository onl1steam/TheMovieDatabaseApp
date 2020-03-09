//
//  MainScreenViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    enum ScreenNames {
        static let movies = LocalizedStrings.moviesTabBar
        static let favorite = LocalizedStrings.favoriteTabBar
        static let account = LocalizedStrings.accountTabBar
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let filmsVC = MoviesViewController()
        filmsVC.tabBarItem = UITabBarItem(title: ScreenNames.movies, image: Images.movie, tag: 0)
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: ScreenNames.favorite, image: Images.favorite, tag: 0)
        
        let accountVC = AccountViewController()
        accountVC.tabBarItem = UITabBarItem(title: ScreenNames.account, image: Images.account, tag: 0)
        
        let tabBarList = [filmsVC, favoritesVC, accountVC]
        viewControllers = tabBarList
    }
    
    func setupColorScheme() {
        tabBar.tintColor = Colors.orange
        tabBar.unselectedItemTintColor = Colors.light
        tabBar.isTranslucent = false
        tabBar.barTintColor = Colors.tabBarBackground
    }
}
