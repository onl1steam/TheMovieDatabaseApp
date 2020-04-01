//
//  FavoritesCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

protocol FavoritesCoordinatorType: Coordinator {
    
}

final class FavoritesCoordinator: FavoritesCoordinatorType {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: TabBarCoordinatorType?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favoritesVC = FavoritesViewController()
        favoritesVC.delegate = self
        favoritesVC.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.favoriteTabBar,
            image: .favoritesTabBar,
            tag: 1)
        navigationController.pushViewController(favoritesVC, animated: true)
    }
}
