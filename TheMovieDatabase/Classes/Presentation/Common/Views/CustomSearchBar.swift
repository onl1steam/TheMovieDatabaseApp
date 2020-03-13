//
//  CustomSearchBar.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    // MARK: - Types
    
    private enum CustomSearchBarConstants {
        static let backgroundColor = Colors.tabBarBackground
        static let cornerRadius: CGFloat = 8
        static let fontSize: CGFloat = 16
        static let searchImage = Images.search
        static let clearImage = Images.clearSearchText
    }
    
    // MARK: - Public methods
    
    func configure() {
        setImages()
        setupTextField()
    }
    
    // MARK: - Private Methods
    
    private func setImages() {
        setImage(CustomSearchBarConstants.searchImage, for: .search, state: .normal)
        setImage(CustomSearchBarConstants.clearImage, for: .clear, state: .normal)
    }
    
    private func setupTextField() {
        if #available(iOS 13.0, *) {
            searchTextField.backgroundColor = CustomSearchBarConstants.backgroundColor
        }
        if let textField = value(forKey: "searchField") as? UITextField {
            textField.textColor = Colors.light
            textField.font = textField.font?.withSize(CustomSearchBarConstants.fontSize)
            setupTextFieldPlaceholder(textField: textField)
            if let backgroundview = textField.subviews.first {
                setupBackgroundView(backgroundview)
            }
        }
    }
    
    private func setupTextFieldPlaceholder(textField: UITextField) {
        let textFieldPlaceholder = textField.value(forKey: "placeholderLabel") as? UILabel
        textFieldPlaceholder?.textColor = Colors.placeholderText
    }
    
    private func setupBackgroundView(_ view: UIView) {
        view.backgroundColor = CustomSearchBarConstants.backgroundColor
        view.layer.cornerRadius = CustomSearchBarConstants.cornerRadius
        view.clipsToBounds = true
    }
}
