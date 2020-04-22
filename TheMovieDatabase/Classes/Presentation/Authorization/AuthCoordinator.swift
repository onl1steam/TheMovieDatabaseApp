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
    
    /// Переход на страницу создания пинкода
    func createPinCode()
    
    /// Переход на страницу подтверждения пин-кода
    ///
    /// - Parameters:
    ///     - enteredPinCode: Пароль, введенный на стронице создания пин-кода
    func confirmPinCode(enteredPinCode: String)
    
    /// Переход на страницу входа через пин-код
    func loginWithPinCode()
    
    /// Вход в приложение после ввода пин-кода
    func enterApp()
    
    /// Переходит на предыдущий экран
    func previousViewController()
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
        if isLoggedIn() {
            let pinCodeAuthorizationViewController = PinCodeAuthorizationViewController()
            pinCodeAuthorizationViewController.delegate = self
            navigationController.pushViewController(pinCodeAuthorizationViewController, animated: true)
        } else {
            let authViewController = AuthorizationViewController()
            authViewController.delegate = self
            navigationController.pushViewController(authViewController, animated: true)
        }
    }
    
    // MARK: - AuthorizationCoordinator
    
    func authLogin() {
        createPinCode()
    }
    
    func createPinCode() {
        let createPinCodeViewController = CreatePinCodeViewController()
        createPinCodeViewController.delegate = self
        navigationController.pushViewController(createPinCodeViewController, animated: true)
    }
    
    func confirmPinCode(enteredPinCode: String) {
        let confirmPinCodeViewController = ConfirmPinCodeViewController(enteredPinCode: enteredPinCode)
        confirmPinCodeViewController.delegate = self
        navigationController.pushViewController(confirmPinCodeViewController, animated: true)
    }
    
    func loginWithPinCode() {
        let pinCodeAuthorizationViewController = PinCodeAuthorizationViewController()
        pinCodeAuthorizationViewController.delegate = self
        navigationController.pushViewController(pinCodeAuthorizationViewController, animated: true)
    }
    
    func enterApp() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.login()
    }
    
    func previousViewController() {
        navigationController.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func isLoggedIn() -> Bool {
        let isLoggedIn = false
        return isLoggedIn
    }
}
