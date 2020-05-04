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
    
    let validationService: Validation
    let authService: Authorization
    let sessionService: Session
    
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
        let isHidden = activityIndicator.isHidden
        if isHidden {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    func toggleLoginButton(isTextFieldsBlank: Bool) {
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

    func showError(_ error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
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
        authorizeWithData(login: loginTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func loginEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.purpure)
    }
    
    @IBAction func loginTextFieldChanged(_ sender: CustomTextField) {
        checkTextFieldsState(loginText: loginTextField.text, passwordText: passwordTextField.text)
    }
    
    @IBAction func loginEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.darkBlue)
    }
    
    @IBAction func passwordEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.purpure)
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: CustomTextField) {
        checkTextFieldsState(loginText: loginTextField.text, passwordText: passwordTextField.text)
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
    
    private func validateResponse(_ response: Result<String, Error>) {
        switch response {
        case .success(let sessionId):
            errorLabel.isHidden = true
            sessionService.setupSessionId(sessionId: sessionId)
            presentInFullScreen(TabBarViewController(), animated: true, completion: nil)
        case .failure(let error):
            showError(error.localizedDescription)
        }
    }
}
