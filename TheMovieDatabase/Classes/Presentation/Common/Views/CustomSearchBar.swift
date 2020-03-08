//
//  CustomSearchBar.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    enum CustomSearchBarConstants {
        static let backgroundColor = Colors.tabBarBackground
        static let cornerRadius: CGFloat = 8
        static let searchImage = Images.search
    }
    
    func configure() {
        if let textField = value(forKey: "searchField") as? UITextField {
            if let backgroundview = textField.subviews.first {
                backgroundview.backgroundColor = CustomSearchBarConstants.backgroundColor
                backgroundview.layer.cornerRadius = CustomSearchBarConstants.cornerRadius
                backgroundview.clipsToBounds = true
            }
        }
        setImage(CustomSearchBarConstants.searchImage, for: .search, state: .normal)
    }
}
