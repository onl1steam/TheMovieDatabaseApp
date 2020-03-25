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
    
    var viewController: AuthorizationViewController { rootViewController as! AuthorizationViewController }
    
    override func setUp() {
        super.setUp()
        let authViewModel = AuthorizationViewModelMock()
        let authVC = AuthorizationViewController(authViewModel: authViewModel)
        authViewModel.setupDelegate(delegate: authVC)
        rootViewController = authVC
    }
    
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
        viewController.authViewModel.authorizeWithData(login: "Foo", password: "Barr")
        XCTAssert(viewController.activityIndicator.isHidden)
    }
    
    func testLoginButtonDisabled() {
        viewController.authViewModel.checkTextFieldsState(loginText: nil, passwordText: nil)
        XCTAssert(!viewController.loginButton.isEnabled)
    }
    
    func testShowingError() {
        viewController.showError("Foo")
        XCTAssertEqual(viewController.errorLabel.text, "Foo")
    }
    
    func testHidingErrorLabel() {
        viewController.hideErrorLabel()
        XCTAssert(viewController.errorLabel.isHidden)
    }
    
    func testTogglingTextFieldState() {
        viewController.toggleTextFieldState(isBlank: true)
        XCTAssert(viewController.isTextFieldsBlank)
    } 
}
