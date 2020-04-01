//
//  AuthCoordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 31.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Координатор для экрана авторизации
protocol AuthorizationCoordinator: Coordinator {
    
    /// Авторизация в приложении
    func authLogin()
}

final class AuthCoordinator: AuthorizationCoordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: ApplicationCoordinator?
    
    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
    }
    
    func start() {
        let authVC = AuthorizationViewController()
        authVC.delegate = self
        navigationController.pushViewController(authVC, animated: true)
    }
    
    func authLogin() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.login()
    }
}
