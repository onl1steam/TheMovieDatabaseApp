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
    case invalidInput
    case unknownError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .blankFields:
            return LocalizedStrings.blankFields
        case .invalidInput:
            return LocalizedStrings.invalidInput
        case .unknownError:
            return LocalizedStrings.unknownError
        }
    }
}

extension AuthError: Equatable {}
