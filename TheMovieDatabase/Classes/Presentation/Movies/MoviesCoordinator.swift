//
//  MoviesCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

protocol MoviesCoordinatorType: Coordinator {
    
}

final class MoviesCoordinator: MoviesCoordinatorType {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: TabBarCoordinatorType?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let moviesVC = MoviesViewController()
        moviesVC.delegate = self
        moviesVC.tabBarItem = UITabBarItem(title: TabBarScreenStrings.moviesTabBar, image: .moviesTabBar, tag: 0)
        navigationController.pushViewController(moviesVC, animated: true)
    }
}
