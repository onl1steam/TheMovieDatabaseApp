//
//  FavoritesCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Координатор для экрана избранных фильмов
protocol FavoritesCoordinatorType: Coordinator, SearchCoordinator, MovieDetailsDelegate {}

final class FavoritesCoordinator: FavoritesCoordinatorType {
    
    // MARK: - Public Properties
    
    weak var parentCoordinator: TabBarCoordinatorType?
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.delegate = self
        favoritesViewController.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.favoriteTabBar,
            image: .favoritesTabBar,
            tag: 1)
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
    
    // MARK: - SearchCoordinator
    
    func showMovieDetails(movieData: MovieDetails) {
        let movieDetailsViewController = MovieDetailsViewController(movieDetails: movieData)
        movieDetailsViewController.delegate = self
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    // MARK: - MovieDetailsDelegate
    
    func arrowBackTapped() {
        navigationController.popViewController(animated: true)
    }
    
    func favoriteTapped() {
        
    }
}
