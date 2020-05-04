//
//  ArrayExtension.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 04.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

extension Array {
    
    /// Subscript для безопасного доступа к элементам массива.
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
