//
//  UIImageViewExtension.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Сделать скругление по углам для изображения.
    ///
    /// - Parameters:
    ///     - cornerRadius: Радиус закругления.
    func makeRounded(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
