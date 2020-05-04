//
//  UICollectionViewCellExtension.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 03.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    /// Строка, использующаяся в reuseIdentifier ячейки
    var identifier: String {
        let string = String(describing: Self.self)
        return string
    }
}
