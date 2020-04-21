//
//  UIButtonExtension.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 20.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

extension UIButton {
    
    @IBInspectable var adjustFontSizeToWidth: Bool {
        get {
            return self.titleLabel?.adjustsFontSizeToFitWidth ?? false
        }
        set {
            self.titleLabel?.numberOfLines = 1
            self.titleLabel?.adjustsFontSizeToFitWidth = newValue
            self.titleLabel?.lineBreakMode = .byClipping
            self.titleLabel?.baselineAdjustment = .alignCenters
        }
    }
}
