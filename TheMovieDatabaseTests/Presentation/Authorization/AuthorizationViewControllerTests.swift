//
//  AuthorizationViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class AuthorizationViewControllerTests: ViewControllerTestCase {
    
    // MARK: - Public Properties
    
    var viewController: AuthorizationViewController { rootViewController as! AuthorizationViewController }
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        let authVC = AuthorizationViewController(
            validationService: ServiceLayer.shared.validationService,
            authService: AuthServiceMock(),
            sessionService: SessionServiceMock())
        rootViewController = authVC
    }
    
    // MARK: - Tests
    
    func testInterfaceItemsLabels() {
        XCTAssertEqual(viewController.authInfoLabel.text, "Укажите логин и пароль, которые вы использовали для входа")
        XCTAssertEqual(viewController.welcomeLabel.text, "Добро пожаловать!")
        XCTAssertEqual(viewController.loginTextField.placeholder, "Логин")
        XCTAssertEqual(viewController.passwordTextField.placeholder, "Пароль")
    }
    
    func testSwitchingVisibility() {
        XCTAssert(viewController.passwordTextField.isSecureTextEntry)
        XCTAssertEqual(viewController.visibilityButton.backgroundImage(for: .normal), Images.visibility)
        viewController.visibilityButtonTapped()
        XCTAssert(!viewController.passwordTextField.isSecureTextEntry)
        XCTAssertEqual(viewController.visibilityButton.backgroundImage(for: .normal), Images.visibilityNone)
    }
    
    func testToggleIndicator() {
        viewController.toggleIndicator()
        XCTAssert(!viewController.activityIndicator.isHidden)
        viewController.authorizeWithData(login: "Foo", password: "Barr")
        XCTAssert(viewController.activityIndicator.isHidden)
    }
    
    func testLoginButtonDisabled() {
        viewController.checkTextFieldsState(loginText: nil, passwordText: nil)
        XCTAssert(!viewController.loginButton.isEnabled)
        XCTAssertEqual(viewController.loginButton.backgroundColor, Colors.disabledButtonBackground)
        XCTAssertEqual(viewController.loginButton.titleColor(for: .normal), Colors.disabledButtonText)
    }
    
    func testLoginButtonEnabled() {
        viewController.toggleLoginButton(isTextFieldsBlank: false)
        XCTAssert(viewController.loginButton.isEnabled)
        XCTAssertEqual(viewController.loginButton.backgroundColor, Colors.customOrange)
        XCTAssertEqual(viewController.loginButton.titleColor(for: .normal), Colors.customLight)
    }
    
    func testShowingError() {
        viewController.showError("Foo")
        XCTAssertEqual(viewController.errorLabel.text, "Foo")
    }
    
    func testTapLoginButton() {
        viewController.loginButtonTapped(self)
        XCTAssert(!viewController.loginButton.isEnabled)
    }
    
    func testBeginLoginEditing() {
        viewController.loginEditingDidBegin(viewController.loginTextField)
        XCTAssertEqual(viewController.loginTextField.layer.borderColor, Colors.customPurpure.cgColor)
    }
    
    func testEndLoginEditing() {
        viewController.loginEditingDidEnd(viewController.loginTextField)
        XCTAssertEqual(viewController.loginTextField.layer.borderColor, Colors.darkBlue.cgColor)
    }
    
    func testLoginTextFieldChanging() {
        viewController.loginTextFieldChanged(viewController.loginTextField)
        XCTAssert(!viewController.loginButton.isEnabled)
    }
    
    func testBeginPasswordEditing() {
        viewController.passwordEditingDidBegin(viewController.passwordTextField)
        XCTAssertEqual(viewController.passwordTextField.layer.borderColor, Colors.customPurpure.cgColor)
    }
    
    func testPasswordTextFieldChanging() {
        viewController.passwordTextFieldChanged(viewController.passwordTextField)
        XCTAssert(!viewController.loginButton.isEnabled)
    }
    
    func testEndPasswordEditing() {
        viewController.passwordEditingDidEnd(viewController.passwordTextField)
        XCTAssertEqual(viewController.passwordTextField.layer.borderColor, Colors.darkBlue.cgColor)
    }
    
    func testChangingErrorLabelState() {
        viewController.errorLabel.isHidden = false
        viewController.authorizeWithData(login: "Foo", password: "Bar")
        XCTAssert(viewController.errorLabel.isHidden)
    }
    
    func testChangingErrorLabelStates() {
        viewController.checkTextFieldsState(loginText: nil, passwordText: nil)
        XCTAssert(!viewController.loginButton.isEnabled)
    }
}
