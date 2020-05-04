//
//  UIViewExtension.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

extension UIView {
    
    func subview<T: UIView>(withAccessibilityIdentifier accessibilityIdentifier: String) -> T? {
        if self.accessibilityIdentifier == accessibilityIdentifier { return self as? T }
        
        for subview in subviews {
            if let view = subview.subview(withAccessibilityIdentifier: accessibilityIdentifier) {
                return view as? T
            }
        }
        
        return nil
    }
}
