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
    
    // MARK: - Public Properties
    
    weak var parentCoordinator: ApplicationCoordinator?
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let authViewController = AuthorizationViewController()
        authViewController.delegate = self
        navigationController.pushViewController(authViewController, animated: true)
    }
    
    // MARK: - AuthorizationCoordinator
    
    func authLogin() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.login()
    }
}
