//
//  AuthorizationViewControllerMock.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import UIKit

protocol AuthorizationVCMock: AuthorizationViewModelDelegate {
    
    /// Лейбл ошибки в моке
    var errorLabel: UILabel { get set }
    
    /// Индикатор активности в моке
    var activityIndicator: UIActivityIndicatorView { get set }
    
    /// Кнопка логина в моке
    var loginButton: UIButton { get set }
    
    /// Заполненость полей в моке
    var isTextFieldsBlank: Bool { get set }
}

final class AuthorizationViewControllerMock: AuthorizationVCMock {
    
    var errorLabel: UILabel = UILabel()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var loginButton: UIButton = UIButton()
    var isTextFieldsBlank = true
    
    func hideErrorLabel() {
        errorLabel.isHidden = true
    }
    
    func showError(_ error: String) {
        errorLabel.isHidden = true
        errorLabel.text = error
    }
    
    func toggleLoginButton() {
        if isTextFieldsBlank {
            loginButton.isEnabled = false
        } else {
            loginButton.isEnabled = true
        }
    }
    
    func toggleTextFieldState(isBlank: Bool) {
        isTextFieldsBlank = isBlank
    }
    
    func toggleIndicator() {
        let isHidden = activityIndicator.isHidden
        if isHidden {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    func presentViewController(_ vc: UIViewController) {}
}
