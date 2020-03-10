//
//  MainScreenViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let filmsVC = MoviesViewController()
        filmsVC.tabBarItem = UITabBarItem(title: TabBarScreenStrings.moviesTabBar, image: Images.moviesTabBar, tag: 0)
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.favoriteTabBar,
            image: Images.favoritesTabBar,
            tag: 0)
        
        let accountVC = AccountViewController()
        accountVC.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.accountTabBar,
            image: Images.accountTabBar,
            tag: 0)
        
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
