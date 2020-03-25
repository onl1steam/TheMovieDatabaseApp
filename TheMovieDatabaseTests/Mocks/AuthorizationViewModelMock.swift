//
//  AuthorizationViewModelMock.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase

final class AuthorizationViewModelMock: AuthorizationViewModelType {
    
    weak var delegate: AuthorizationViewModelDelegate?
    var isBlank: Bool = true
    
    func checkTextFieldsState(loginText: String?, passwordText: String?) {
        delegate?.toggleTextFieldState(isBlank: isBlank)
        delegate?.toggleLoginButton()
    }
    
    func authorizeWithData(login: String, password: String) {
        delegate?.toggleIndicator()
    }
    
    func setupDelegate(delegate: AuthorizationViewModelDelegate) {
        self.delegate = delegate
    }
}
