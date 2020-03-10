//
//  AuthorizationViewModel.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 10.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

protocol AuthorizationViewModelType: class {
    func checkTextFieldsState(loginText: String?, passwordText: String?)
    func authorizeWithData(login: String, password: String)
    func setupDelegate(delegate: ViewModelDelegate)
}

class AuthorizationViewModel: AuthorizationViewModelType {
    let authService: Authorization
    let sessionService: Session
    weak var delegate: ViewModelDelegate?
    
    init(
        authService: Authorization = ServiceLayer.shared.authService,
        sessionService: Session = ServiceLayer.shared.sessionService) {
        self.authService = authService
        self.sessionService = sessionService
    }
    
    private func validateResponse(_ response: Result<String, AuthError>) {
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
    
    func checkTextFieldsState(loginText: String?, passwordText: String?) {
        authService.validateUserInput(login: loginText, password: passwordText) { [weak self] response in
            guard let self = self, let delegate = self.delegate else { return }
            switch response {
            case .success:
                delegate.toggleTextFieldState(isHidden: false)
                delegate.toggleLoginButton()
            case .failure:
                delegate.toggleTextFieldState(isHidden: true)
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
    
    func setupDelegate(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
}
