//
//  AuthorizationViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    @IBOutlet weak var loginTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var authInfoLabel: UILabel!
    @IBOutlet weak var loginButton: RoundedButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let visibilityButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setBackgroundImage(Images.visibility, for: .normal)
        button.addTarget(self, action: #selector(visibilityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let authService: Authorization
    let sessionService: Session
    
    private var isTextFieldsBlank = true
    
    init(
        authService: Authorization = ServiceLayer.shared.authService,
        sessionService: Session = ServiceLayer.shared.sessionService) {
        self.authService = authService
        self.sessionService = sessionService
        super.init(nibName: "AuthorizationViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedStrings()
        toggleLoginButton()
        activityIndicator.isHidden = true
        activityIndicator.color = Colors.light
        setupLoginTextField()
        setupPasswordTextField()
    }
    
    private func setupLocalizedStrings() {
        loginTextField.placeholder = LocalizedStrings.loginPlaceholder
        passwordTextField.placeholder = LocalizedStrings.passwordPlaceholder
        welcomeLabel.text = LocalizedStrings.authWelcome
        authInfoLabel.text = LocalizedStrings.authInfo
        loginButton.setTitle(LocalizedStrings.loginButtonText, for: .normal)
    }
    
    func setupLoginTextField() {
        loginTextField.setupPlaceholderColor(Colors.gray)
        loginTextField.setupBorderColor(Colors.darkBlue)
        loginTextField.textColor = Colors.light
    }
    
    func setupPasswordTextField() {
        passwordTextField.textColor = Colors.light
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = visibilityButton
        passwordTextField.rightViewMode = .always
        passwordTextField.setupPlaceholderColor(Colors.gray)
        passwordTextField.setupBorderColor(Colors.darkBlue)
    }
    
    private func validateResponse(_ response: Result<String, AuthError>) {
        switch response {
        case .success(let sessionId):
            errorLabel.isHidden = true
            sessionService.setupSessionId(sessionId: sessionId)
            presentInFullScreen(TabBarViewController(), animated: true, completion: nil)
        case .failure(let error):
            errorLabel.text = error.localizedDescription
            errorLabel.isHidden = false
        }
    }
    
    private func toggleIndicator() {
        let isHidden = activityIndicator.isHidden
        if isHidden {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    private func toggleLoginButton() {
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
    
    private func checkTextFieldsState() {
        authService.validateUserInput(
            login: loginTextField.text,
            password: passwordTextField.text) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.isTextFieldsBlank = false
                self.toggleLoginButton()
            case .failure:
                self.isTextFieldsBlank = true
                self.toggleLoginButton()
            }
        }
    }
    
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
        let userData = User(login: loginTextField.text!, password: passwordTextField.text!)
        toggleIndicator()
        authService.authorizeWithUser(user: userData) { [weak self] response in
            guard let self = self else { return }
            self.validateResponse(response)
            self.toggleIndicator()
        }
    }
    
    @IBAction func loginEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.purpure)
    }
    
    @IBAction func loginTextFieldChanged(_ sender: CustomTextField) {
        checkTextFieldsState()
    }
    
    @IBAction func loginEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.darkBlue)
    }
    
    @IBAction func passwordEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.purpure)
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: CustomTextField) {
        checkTextFieldsState()
    }
    
    @IBAction func passwordEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.darkBlue)
    }
}
