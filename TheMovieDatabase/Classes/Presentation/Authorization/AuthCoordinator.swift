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
    let authViewController = AuthorizationViewController()
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        authViewController.delegate = self
        navigationController.pushViewController(authViewController, animated: true)
    }
    
    // MARK: - AuthorizationCoordinator
    
    func authLogin() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.login()
    }
}
