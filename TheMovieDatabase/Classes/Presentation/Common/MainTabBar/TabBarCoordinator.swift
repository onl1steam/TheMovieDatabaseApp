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
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let tabBarViewController = TabBarViewController()
        tabBarViewController.controllerDelegate = self
        setupTabBarCoordinators(tabBarViewController: tabBarViewController)
        navigationController.pushViewController(tabBarViewController, animated: true)
    }
    
    // MARK: - TabBarCoordinatorType
    
    func logout() {
        parentCoordinator?.logout()
        parentCoordinator?.childDidFinish(self)
    }
    
    // MARK: - Private Methods
    
    private func setupTabBarCoordinators(tabBarViewController: TabBarViewController) {
        tabBarViewController.moviesCoordinator.parentCoordinator = self
        tabBarViewController.favoritesCoordinator.parentCoordinator = self
        tabBarViewController.accountCoordinator.parentCoordinator = self
    }
}
