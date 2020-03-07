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
    let visibilityButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setBackgroundImage(Images.visibility, for: .normal)
        button.addTarget(self, action: #selector(visibilityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginTextField()
        setupPasswordTextField()
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
    }
    
    @IBAction func loginEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.purpure)
    }
    @IBAction func loginEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.darkBlue)
    }
    @IBAction func passwordEditingDidBegin(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.purpure)
    }
    @IBAction func passwordEditingDidEnd(_ sender: CustomTextField) {
        sender.setupBorderColor(Colors.darkBlue)
    }
    
}
