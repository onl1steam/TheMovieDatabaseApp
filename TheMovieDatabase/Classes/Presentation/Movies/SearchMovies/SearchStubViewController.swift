//
//  SearchStubViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 31.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Заглушка в случае безрезультатного поиска фильмов
final class SearchStubViewController: UIViewController {

   // MARK: - Private Properties
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = SearchMoviesStrings.searchStubLabel
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .customLight
        return label
    }()
    
    private let placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .searchStub
        return imageView
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupPlaceholderLabelConstraints()
        setupPlaceholderImageViewConstraints()
        setupAccessability()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(placeholderLabel)
        view.addSubview(placeholderImageView)
    }
    
    private func setupAccessability() {
        isAccessibilityElement = true
        view.accessibilityIdentifier = "search_placeholder"
        
        placeholderLabel.isAccessibilityElement = true
        placeholderLabel.accessibilityIdentifier = "search_placeholder_label"
        
        placeholderImageView.isAccessibilityElement = true
        placeholderImageView.accessibilityIdentifier = "search_placeholder_imageView"
    }
    
    private func setupPlaceholderLabelConstraints() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 17).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func setupPlaceholderImageViewConstraints() {
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.heightAnchor.constraint(equalToConstant: 193).isActive = true
        placeholderImageView.widthAnchor.constraint(equalToConstant: 248).isActive = true
        placeholderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        placeholderImageView.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: 100).isActive = true
    }
}
