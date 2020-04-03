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
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: TabBarCoordinatorType?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let accountViewController = AccountViewController()
        accountViewController.delegate = self
        accountViewController.tabBarItem = UITabBarItem(
            title: TabBarScreenStrings.accountTabBar,
            image: .accountTabBar,
            tag: 2)
        navigationController.pushViewController(accountViewController, animated: true)
    }
    
    func logout() {
        parentCoordinator?.logout()
    }
}
