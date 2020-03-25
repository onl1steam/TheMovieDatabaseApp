//
//  AuthorizationViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Делегат для ViewModel экрана авторизации.
protocol AuthorizationViewModelDelegate: class {
    
    /// Скрыть строку ошибки.
    func hideErrorLabel()
    
    /// Показать на экране авторизации ошибку.
    ///
    /// - Parameters:
    ///   - error: Строка, описывающую ошибку.
    func showError(_ error: String)
    
    /// Переходит на следующий экран.
    ///
    /// - Parameters:
    ///   - vc: Экран, на который необходимо перейти.
    func presentViewController(_ vc: UIViewController)
    
    /// Переключает состояние кнопки логина.
    func toggleLoginButton()
    
    /// Передает состояние заполненности полей в ViewController
    ///
    /// - Parameters:
    ///   - isBlank: Заполнены ли поля авторизации.
    func toggleTextFieldState(isBlank: Bool)
    
    /// Переключить индикатор загрузки.
    func toggleIndicator()
}

final class AuthorizationViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var loginTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var authInfoLabel: UILabel!
    @IBOutlet weak var loginButton: RoundedButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public Properties
    
    let visibilityButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setBackgroundImage(Images.visibility, for: .normal)
        button.addTarget(self, action: #selector(visibilityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let authViewModel: AuthorizationViewModelType

    // MARK: - Private Properties
    
    private(set) var isTextFieldsBlank = true
    
    // MARK: - Initializers
    
    init(authViewModel: AuthorizationViewModelType = AuthorizationViewModel()) {
        self.authViewModel = authViewModel
        super.init(nibName: "AuthorizationViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        authViewModel.setupDelegate(delegate: self)
        setupLocalizedStrings()
        toggleLoginButton()
        setupActivityIndicator()
        setupLoginTextField()
        setupPasswordTextField()
    }
    
    // MARK: - IBAction
    
    @objc func visibilityButtonTapped() {
        let isPasswordHidden = passwordTextField.isSecureTextEntry
        if isPasswordHidden {
            visibilityButton.setBackgroundImage(Images.visibilityNone, for: .normal)
            passwordTextField.isSecureTextEntry = !isPasswordHidden
        } else {
            visibilityButton.setBackgroundImage(Images.visibility, for: .normal)
            passwordTextField.isSecureTextEntry = !isPasswordHidden
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        toggleIndicator()
        authViewModel.authorizeWithData(login: loginTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func loginEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.purpure)
    }
    
    @IBAction func loginTextFieldChanged(_ sender: CustomTextField) {
        authViewModel.checkTextFieldsState(loginText: loginTextField.text, passwordText: passwordTextField.text)
    }
    
    @IBAction func loginEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.darkBlue)
    }
    
    @IBAction func passwordEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.purpure)
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: CustomTextField) {
        authViewModel.checkTextFieldsState(loginText: loginTextField.text, passwordText: passwordTextField.text)
    }
    
    @IBAction func passwordEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.darkBlue)
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = Colors.backgroundBlack
        welcomeLabel.tintColor = Colors.light
        authInfoLabel.tintColor = Colors.light
        errorLabel.tintColor = Colors.red
        loginButton.backgroundColor = Colors.disabledButtonBackground
        loginButton.tintColor = Colors.disabledButtonText
    }
    
    private func setupLocalizedStrings() {
        loginTextField.placeholder = AuthScreenStrings.loginPlaceholder
        passwordTextField.placeholder = AuthScreenStrings.passwordPlaceholder
        welcomeLabel.text = AuthScreenStrings.authWelcome
        authInfoLabel.text = AuthScreenStrings.authInfo
        loginButton.setTitle(AuthScreenStrings.loginButtonText, for: .normal)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.color = Colors.light
    }
    
    private func setupLoginTextField() {
        loginTextField.setupPlaceholderColor(Colors.gray)
        loginTextField.setupBorderColor(Colors.darkBlue)
        loginTextField.textColor = Colors.light
    }
    
    private func setupPasswordTextField() {
        passwordTextField.textColor = Colors.light
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = visibilityButton
        passwordTextField.rightViewMode = .always
        passwordTextField.setupPlaceholderColor(Colors.gray)
        passwordTextField.setupBorderColor(Colors.darkBlue)
    }
}

// MARK: - ViewModelDelegate

extension AuthorizationViewController: AuthorizationViewModelDelegate {
    
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
    
    func toggleLoginButton() {
        if isTextFieldsBlank {
            loginButton.backgroundColor = Colors.disabledButtonBackground
            loginButton.setTitleColor(Colors.disabledButtonText, for: .normal)
            loginButton.isEnabled = false
        } else {
            loginButton.backgroundColor = Colors.orange
            loginButton.setTitleColor(Colors.light, for: .normal)
            loginButton.isEnabled = true
        }
    }
    
    func toggleTextFieldState(isBlank: Bool) {
        isTextFieldsBlank = isBlank
    }
    
    func hideErrorLabel() {
        errorLabel.isHidden = true
    }
    
    func showError(_ error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
    }
    
    func presentViewController(_ vc: UIViewController) {
        presentInFullScreen(vc, animated: true, completion: nil)
    }
}
