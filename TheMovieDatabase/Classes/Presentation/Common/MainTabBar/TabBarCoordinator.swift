//
//  TabBarCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Координатор для TabBar
protocol TabBarCoordinatorType: Coordinator {
    
    /// Выход из текущей сессии
    func logout()
}

final class TabBarCoordinator: TabBarCoordinatorType {
    
    // MARK: - Public Properties
    
    weak var parentCoordinator: ApplicationCoordinator?
    let tabBarViewController = TabBarViewController()
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        tabBarViewController.controllerDelegate = self
        setupTabBarCoordinators(tabBarViewController: tabBarViewController)
        navigationController.pushViewController(tabBarViewController, animated: true)
    }
    
    // MARK: - TabBarCoordinatorType
    
    func logout() {
        parentCoordinator?.logout()
        parentCoordinator?.childDidFinish(self)
    }
    
    // MARK: - Public Methods
    
    func setupTransitionDelegate(_ delegate: UIViewControllerTransitioningDelegate) {
        tabBarViewController.transitioningDelegate = delegate
    }
    
    // MARK: - Private Methods
    
    private func setupTabBarCoordinators(tabBarViewController: TabBarViewController) {
        tabBarViewController.moviesCoordinator.parentCoordinator = self
        tabBarViewController.favoritesCoordinator.parentCoordinator = self
        tabBarViewController.accountCoordinator.parentCoordinator = self
    }
}
