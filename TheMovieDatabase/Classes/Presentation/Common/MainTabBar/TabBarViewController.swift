//
//  MainScreenViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Public Properties
    
    let moviesCoordinator = MoviesCoordinator(navigationController: UINavigationController())
    let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())
    let accountCoordinator = AccountCoordinator(navigationController: UINavigationController())
    
    weak var controllerDelegate: TabBarCoordinatorType?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        startCoordinators([moviesCoordinator, favoritesCoordinator, accountCoordinator])
        setupViewControllers()
        setupTabBar()
        setupAccessability()
    }
    
    // MARK: - Private Methods
    
    private func setupAccessability() {
        tabBar.isAccessibilityElement = true
        tabBar.accessibilityIdentifier = "tabBar"
    }
    
    private func startCoordinators(_ coordinators: [Coordinator]) {
        coordinators.forEach { $0.start() }
    }
    
    private func setupTabBar() {
        let fontSize: CGFloat = 12
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    private func setupViewControllers() {
        let tabBarList = [
            moviesCoordinator.navigationController,
            favoritesCoordinator.navigationController,
            accountCoordinator.navigationController]
        viewControllers = tabBarList
    }
    
    private func setupColorScheme() {
        tabBar.tintColor = .customOrange
        tabBar.unselectedItemTintColor = .customLight
        tabBar.isTranslucent = false
        tabBar.barTintColor = .tabBarBackground
    }
}
