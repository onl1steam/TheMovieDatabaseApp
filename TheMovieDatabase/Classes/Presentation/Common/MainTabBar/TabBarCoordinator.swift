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
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: ApplicationCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarViewController = TabBarViewController()
        tabBarViewController.controllerDelegate = self
        setupTabBarCoordinators(tabBarViewController: tabBarViewController)
        navigationController.pushViewController(tabBarViewController, animated: true)
    }
    
    func logout() {
        parentCoordinator?.logout()
        parentCoordinator?.childDidFinish(self)
    }
    
    private func setupTabBarCoordinators(tabBarViewController: TabBarViewController) {
        tabBarViewController.moviesCoordinator.parentCoordinator = self
        tabBarViewController.favoritesCoordinator.parentCoordinator = self
        tabBarViewController.accountCoordinator.parentCoordinator = self
    }
}
