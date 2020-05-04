//
//  AuthorizationViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var loginTextField: CustomTextField!
    @IBOutlet private var passwordTextField: CustomTextField!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var welcomeLabel: UILabel!
    @IBOutlet private var authInfoLabel: UILabel!
    @IBOutlet private var loginButton: RoundedButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public Properties
    
    let validationService: Validation
    let authService: Authorization
    let sessionService: Session
    
    weak var delegate: AuthorizationCoordinator?
    
    // MARK: - Private Properties
    
    private lazy var visibilityButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setBackgroundImage(.visibility, for: .normal)
        button.addTarget(self, action: #selector(visibilityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    init(validationService: Validation = ServiceLayer.shared.validationService,
         authService: Authorization = ServiceLayer.shared.authService,
         sessionService: Session = ServiceLayer.shared.sessionService) {
        self.validationService = validationService
        self.authService = authService
        self.sessionService = sessionService
        super.init(nibName: "AuthorizationViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        setupColorScheme()
        setupLocalizedStrings()
        toggleLoginButton(isTextFieldsBlank: true)
        setupActivityIndicator()
        setupLoginTextField()
        setupPasswordTextField()
    }
    
    // MARK: - Public methods
    
    func checkTextFieldsState(loginText: String?, passwordText: String?) {
        let user = User(login: loginText, password: passwordText)
        validationService.validateUserInput(user: user) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.toggleLoginButton(isTextFieldsBlank: false)
            case .failure:
                self.toggleLoginButton(isTextFieldsBlank: true)
            }
        }
    }
    
    func authorizeWithData(login: String, password: String) {
        let userData = User(login: login, password: password)
        authService.authorizeWithUser(user: userData) { [weak self] response in
            guard let self = self else { return }
            self.validateResponse(response)
            self.toggleIndicator()
        }
    }
    
    func toggleIndicator() {
        activityIndicator.isHidden ? activityIndicator.startAnimating(): activityIndicator.stopAnimating()
    }
    
    func toggleLoginButton(isTextFieldsBlank: Bool) {
        if isTextFieldsBlank {
            loginButton.backgroundColor = .disabledButtonBackground
            loginButton.setTitleColor(.disabledButtonText, for: .normal)
            loginButton.isEnabled = false
        } else {
            loginButton.backgroundColor = .customOrange
            loginButton.setTitleColor(.customLight, for: .normal)
            loginButton.isEnabled = true
        }
    }

    func showError(_ error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
    }
    
    // MARK: - IBAction
    
    @objc private func visibilityButtonTapped() {
        let isPasswordHidden = passwordTextField.isSecureTextEntry
        if isPasswordHidden {
            visibilityButton.setBackgroundImage(.visibilityNone, for: .normal)
            passwordTextField.isSecureTextEntry = !isPasswordHidden
        } else {
            visibilityButton.setBackgroundImage(.visibility, for: .normal)
            passwordTextField.isSecureTextEntry = !isPasswordHidden
        }
    }
    
    @IBAction private func loginButtonTapped(_ sender: Any) {
        toggleIndicator()
        authorizeWithData(login: loginTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction private func loginEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(.customPurpure)
    }
    
    @IBAction private func loginTextFieldChanged(_ sender: CustomTextField) {
        checkTextFieldsState(loginText: loginTextField.text, passwordText: passwordTextField.text)
    }
    
    @IBAction private func loginEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(.darkBlue)
    }
    
    @IBAction private func passwordEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(.customPurpure)
    }
    
    @IBAction private func passwordTextFieldChanged(_ sender: CustomTextField) {
        checkTextFieldsState(loginText: loginTextField.text, passwordText: passwordTextField.text)
    }
    
    @IBAction private func passwordEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(.darkBlue)
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
        welcomeLabel.tintColor = .customLight
        authInfoLabel.tintColor = .customLight
        errorLabel.tintColor = .customRed
        loginButton.backgroundColor = .disabledButtonBackground
        loginButton.tintColor = .disabledButtonText
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
        activityIndicator.color = .customLight
    }
    
    private func setupLoginTextField() {
        loginTextField.setupPlaceholderColor(.customGray)
        loginTextField.setupBorderColor(.darkBlue)
        loginTextField.textColor = .customLight
    }
    
    private func setupPasswordTextField() {
        passwordTextField.textColor = .customLight
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = visibilityButton
        passwordTextField.rightViewMode = .always
        passwordTextField.setupPlaceholderColor(.customGray)
        passwordTextField.setupBorderColor(.darkBlue)
    }
    
    private func validateResponse(_ response: Result<String, Error>) {
        switch response {
        case .success(let sessionId):
            errorLabel.isHidden = true
            sessionService.setupSessionId(sessionId: sessionId)
            delegate?.authLogin()
        case .failure(let error):
            showError(error.localizedDescription)
        }
    }
}
