//
//  AuthorizationViewModel.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 10.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// ViewModel для экрана авторизации.
protocol AuthorizationViewModelType: class {
    
    /// Проверить валидность заполненных данных в поля логина и пароля при авторизации.
    ///
    /// - Parameters:
    ///   - loginText: Строка из поля логина.
    ///   - passwordText: Строка из поля пароля.
    func checkTextFieldsState(loginText: String?, passwordText: String?)
    
    /// Авторизовать пользователя в базе данных с введенными данными.
    ///
    /// - Parameters:
    ///   - loginText: Введенный пользователем логин.
    ///   - passwordText: Введенный пользователем пароль.
    func authorizeWithData(login: String, password: String)
    
    /// Установить делегат для ViewModel.
    ///
    /// - Parameters:
    ///   - delegate: Делегат типа AuthorizationViewModelDelegate.
    func setupDelegate(delegate: AuthorizationViewModelDelegate)
}

final class AuthorizationViewModel {
    
    // MARK: - Public Properties
    
    let authService: Authorization
    let validationService: Validation
    let sessionService: Session
    
    // MARK: - Private Properties
    
    private weak var delegate: AuthorizationViewModelDelegate?
    
    // MARK: - Initializers
    
    init(
        authService: Authorization = ServiceLayer.shared.authService,
        sessionService: Session = ServiceLayer.shared.sessionService,
        validationService: Validation = ServiceLayer.shared.validationService) {
        self.authService = authService
        self.sessionService = sessionService
        self.validationService = validationService
    }
    
    // MARK: - Private Methods
    
    private func validateResponse(_ response: Result<String, Error>) {
        guard let delegate = delegate else { return }
        switch response {
        case .success(let sessionId):
            delegate.hideErrorLabel()
            sessionService.setupSessionId(sessionId: sessionId)
            delegate.presentViewController(TabBarViewController())
        case .failure(let error):
            delegate.showError(error.localizedDescription)
        }
    }
}

// MARK: - AuthorizationViewModelType

extension AuthorizationViewModel: AuthorizationViewModelType {
    
    func checkTextFieldsState(loginText: String?, passwordText: String?) {
        let user = User(login: loginText, password: passwordText)
        validationService.validateUserInput(user: user) { [weak self] response in
            guard let self = self, let delegate = self.delegate else { return }
            switch response {
            case .success:
                delegate.toggleTextFieldState(isBlank: false)
                delegate.toggleLoginButton()
            case .failure:
                delegate.toggleTextFieldState(isBlank: true)
                delegate.toggleLoginButton()
            }
        }
    }
    
    func authorizeWithData(login: String, password: String) {
        let userData = User(login: login, password: password)
        authService.authorizeWithUser(user: userData) { [weak self] response in
            guard let self = self, let delegate = self.delegate else { return }
            self.validateResponse(response)
            delegate.toggleIndicator()
        }
    }
    
    func setupDelegate(delegate: AuthorizationViewModelDelegate) {
        self.delegate = delegate
    }
}
