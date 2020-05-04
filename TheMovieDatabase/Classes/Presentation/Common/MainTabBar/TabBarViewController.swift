//
//  MainScreenViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupViewControllers()
        setupTabBar()
    }
    
    // MARK: - Private Methods
    
    private func setupTabBar() {
        let fontSize: CGFloat = 12
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    private func setupViewControllers() {
        let filmsVC = MoviesViewController()
        filmsVC.tabBarItem = UITabBarItem(title: TabBarScreenStrings.moviesTabBar, image: Images.moviesTabBar, tag: 0)
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.favoriteTabBar,
            image: Images.favoritesTabBar,
            tag: 1)
        
        let accountVC = AccountViewController()
        accountVC.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.accountTabBar,
            image: Images.accountTabBar,
            tag: 2)
        
        let tabBarList = [filmsVC, favoritesVC, accountVC]
        viewControllers = tabBarList
    }
    
    private func setupColorScheme() {
        tabBar.tintColor = Colors.orange
        tabBar.unselectedItemTintColor = Colors.light
        tabBar.isTranslucent = false
        tabBar.barTintColor = Colors.tabBarBackground
    }
}
