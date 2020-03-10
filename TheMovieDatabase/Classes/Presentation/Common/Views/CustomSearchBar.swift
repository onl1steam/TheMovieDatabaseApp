//
//  CustomSearchBar.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    private enum CustomSearchBarConstants {
        static let backgroundColor = Colors.tabBarBackground
        static let cornerRadius: CGFloat = 8
        static let fontSize: CGFloat = 16
        static let searchImage = Images.search
        static let clearImage = Images.clearSearchText
    }
    
    func configure() {
        if let textField = value(forKey: "searchField") as? UITextField {
            textField.textColor = Colors.light
            textField.font = textField.font?.withSize(CustomSearchBarConstants.fontSize)
            let textFieldInsideUISearchBarLabel = textField.value(forKey: "placeholderLabel") as? UILabel
            textFieldInsideUISearchBarLabel?.textColor = Colors.light
            if let backgroundview = textField.subviews.first {
                backgroundview.backgroundColor = CustomSearchBarConstants.backgroundColor
                backgroundview.layer.cornerRadius = CustomSearchBarConstants.cornerRadius
                backgroundview.clipsToBounds = true
            }
        }
        setImage(CustomSearchBarConstants.searchImage, for: .search, state: .normal)
        setImage(CustomSearchBarConstants.clearImage, for: .clear, state: .normal)
    }
}
