//
//  AuthorizationViewModelTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights

@testable import TheMovieDatabase
import XCTest

final class AuthorizationViewModelTests: XCTestCase {
    
    // MARK: - Public Properties
    
    var authViewModel: AuthorizationViewModel!
    var authVCMock: AuthorizationViewControllerMock!
    
    // MARK: - setUp

    override func setUp() {
        super.setUp()
        authViewModel = AuthorizationViewModel(
            authService: AuthServiceMock(),
            sessionService: SessionServiceMock(),
            validationService: ValidationServiceMock())
        authVCMock = AuthorizationViewControllerMock()
        authViewModel.setupDelegate(delegate: authVCMock)
    }
    
    // MARK: - Tests
    
    func testChangingErrorLabelState() {
        authVCMock.errorLabel.isHidden = false
        authViewModel.authorizeWithData(login: "Foo", password: "Bar")
        XCTAssert(authVCMock.errorLabel.isHidden)
    }
    
    func testChangingErrorLabelStates() {
        authVCMock.errorLabel.isHidden = false
        authViewModel.checkTextFieldsState(loginText: nil, passwordText: nil)
        XCTAssert(authVCMock.loginButton.isEnabled)
    }
}
