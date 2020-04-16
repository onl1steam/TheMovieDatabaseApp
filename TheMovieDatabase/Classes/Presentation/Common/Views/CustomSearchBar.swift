//
//  CustomSearchBar.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class CustomSearchBar: UISearchBar {
    
    // MARK: - Types
    
    private enum CustomSearchBarConstants {
        static let backgroundColor: UIColor = .tabBarBackground
        static let cornerRadius: CGFloat = 8
        static let fontSize: CGFloat = 16
        static let searchImage: UIImage = .search
        static let clearImage: UIImage = .clearSearchText
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    private func configure() {
        setImages()
        setupTextField()
        searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    private func setImages() {
        setImage(CustomSearchBarConstants.searchImage, for: .search, state: .normal)
        setImage(CustomSearchBarConstants.clearImage, for: .clear, state: .normal)
    }
    
    private func setupTextField() {
        if #available(iOS 13.0, *) {
            searchTextField.backgroundColor = CustomSearchBarConstants.backgroundColor
        }
        
        if let textField = value(forKey: "searchField") as? UITextField {
            textField.textColor = .customLight
            textField.tintColor = .customLight
            textField.backgroundColor = CustomSearchBarConstants.backgroundColor
            textField.keyboardAppearance = .dark
            textField.font = textField.font?.withSize(CustomSearchBarConstants.fontSize)
            
            setupTextFieldPlaceholder(textField: textField)
            if let backgroundview = textField.subviews.first {
                setupBackgroundView(backgroundview)
            }
        }
    }
    
    private func setupTextFieldPlaceholder(textField: UITextField) {
        let textFieldPlaceholder = textField.value(forKey: "placeholderLabel") as? UILabel
        textFieldPlaceholder?.textColor = .placeholderText
    }
    
    private func setupBackgroundView(_ view: UIView) {
        view.backgroundColor = CustomSearchBarConstants.backgroundColor
        view.layer.cornerRadius = CustomSearchBarConstants.cornerRadius
        view.clipsToBounds = true
    }
}
