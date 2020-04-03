//
//  UINavigationBarExtension.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 03.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    /// Удаляет линию под Navigation Bar'ом
    func removeBottomLine() {
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
    }
}
