//
//  AuthError.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

enum AuthError: Error {
    
    case blankFields
    case unknownError
    case invalidPasswordLength
}

extension AuthError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .blankFields:
            return ErrorStrings.blankFields
        case .unknownError:
            return ErrorStrings.unknownError
        case .invalidPasswordLength:
            return ErrorStrings.invalidPasswordLength
        }
    }
}

extension AuthError: Equatable {}
