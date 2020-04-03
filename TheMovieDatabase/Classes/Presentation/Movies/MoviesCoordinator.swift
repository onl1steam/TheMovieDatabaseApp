//
//  MoviesCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Координатор для экрана поиска фильмов
protocol MoviesCoordinatorType: Coordinator, SearchCoordinator {
    
}

final class MoviesCoordinator: MoviesCoordinatorType {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: TabBarCoordinatorType?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let moviesViewController = MoviesViewController()
        moviesViewController.delegate = self
        moviesViewController.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.moviesTabBar,
            image: .moviesTabBar,
            tag: 0)
        navigationController.pushViewController(moviesViewController, animated: true)
    }
    
    func showMovieDetails(data: MovieDetails) {
        
    }
}
