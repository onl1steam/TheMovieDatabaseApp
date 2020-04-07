//
//  MoviesCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Координатор для экрана поиска фильмов
protocol MoviesCoordinatorType: Coordinator, SearchCoordinator, MovieDetailsDelegate {
    
    /// Обрабатывает нажатие на searchBar
    func searchBarTapped()
}

final class MoviesCoordinator: MoviesCoordinatorType {
    
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
        let moviesViewController = MoviesViewController()
        moviesViewController.delegate = self
        moviesViewController.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.moviesTabBar,
            image: .moviesTabBar,
            tag: 0)
        navigationController.pushViewController(moviesViewController, animated: true)
    }
    
    // MARK: - MoviesCoordinatorType
    
    func searchBarTapped() {
        let searchViewController = SearchViewController()
        searchViewController.delegate = self
        navigationController.pushViewController(searchViewController, animated: true)
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
