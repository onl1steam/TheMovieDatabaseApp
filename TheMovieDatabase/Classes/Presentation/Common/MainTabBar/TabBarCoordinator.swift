//
//  TabBarCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

protocol TabBarCoordinatorType: Coordinator {
    
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
        let tabBarVC = TabBarViewController()
        tabBarVC.controllerDelegate = self
        setupTabBarCoordinators(tabBarVC: tabBarVC)
        navigationController.pushViewController(tabBarVC, animated: true)
    }
    
    func logout() {
        parentCoordinator?.logout()
        parentCoordinator?.childDidFinish(self)
    }
    
    private func setupTabBarCoordinators(tabBarVC: TabBarViewController) {
        tabBarVC.moviesCoordinator.parentCoordinator = self
        tabBarVC.favoritesCoordinator.parentCoordinator = self
        tabBarVC.accountCoordinator.parentCoordinator = self
    }
}
