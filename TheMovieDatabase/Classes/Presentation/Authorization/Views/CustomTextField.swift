//
//  CustomTextField.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class CustomTextField: UITextField {
    
    // MARK: - Types
    
    private enum CustomTextFieldConstraints {
        static let borderWidth: CGFloat = 2.0
        static let cornerRadius: CGFloat = 8.0
        static let textPadding: CGFloat = 14
        static let rightViewRightPadding: CGFloat = 14
        static let rightViewTopPadding: CGFloat = 12
        static let rightViewBottomPadding: CGFloat = 12
        static let rightViewWidth: CGFloat = 36
        static let rightViewPadding: CGFloat = 20
    }
    
    // MARK: - Public Properties
    
    var rightViewWidth: CGFloat {
        guard let view = rightView else { return 0 }
        return view.bounds.width
    }
    
    var textPaddingRight: CGFloat {
        guard let view = rightView else { return CustomTextFieldConstraints.textPadding }
        return view.bounds.width + CustomTextFieldConstraints.rightViewPadding
    }
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UIView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = CustomTextFieldConstraints.cornerRadius
        layer.borderWidth = CustomTextFieldConstraints.borderWidth
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = CustomTextFieldConstraints.textPadding
        return bounds.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: textPaddingRight))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let textRect = self.textRect(forBounds: bounds)
        return textRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let bottomPadding = CustomTextFieldConstraints.rightViewBottomPadding
        let topPadding = CustomTextFieldConstraints.rightViewTopPadding
        let rightPadding = CustomTextFieldConstraints.rightViewRightPadding
        return bounds.inset(by: UIEdgeInsets(
            top: topPadding,
            left: layer.bounds.width - CustomTextFieldConstraints.rightViewWidth,
            bottom: bottomPadding,
            right: rightPadding))
    }
    
    // MARK: - Public methods
    
    func setupPlaceholderColor(_ color: UIColor) {
        guard let text = placeholder else { return }
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func setupBorderColor(_ color: UIColor) {
        layer.borderColor = color.cgColor
    }
}
