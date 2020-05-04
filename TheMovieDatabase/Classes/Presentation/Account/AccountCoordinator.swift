//
//  AccountCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Координатор для экрана профиля
protocol AccountCoordinatorType: Coordinator {
    
    /// Выход из текущей сессии
    func logout()
}

final class AccountCoordinator: AccountCoordinatorType {
    
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
        let accountViewController = AccountViewController()
        accountViewController.delegate = self
        accountViewController.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.accountTabBar,
            image: .accountTabBar,
            tag: 2)
        navigationController.pushViewController(accountViewController, animated: true)
    }
    
    // MARK: - AccountCoordinatorType
    
    func logout() {
        parentCoordinator?.logout()
    }
}
