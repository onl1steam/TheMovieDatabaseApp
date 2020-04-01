//
//  LocaleExtension.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

extension Locale {
    
    static var preferredLanguage: String? {
        let languageString = Locale.preferredLanguages.first
        return languageString
    }
}
