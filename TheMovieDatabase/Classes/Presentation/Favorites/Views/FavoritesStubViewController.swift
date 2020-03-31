//
//  FavoritesStubViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class FavoritesStubViewController: UIViewController {
    
    // MARK: - Public Properties
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = FavoritesScreenStrings.blankListLabel
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .customLight
        return label
    }()
    
    let navigationButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.customPurpure, for: .normal)
        button.setTitle(FavoritesScreenStrings.searchFilmsButtonText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    let placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .favoritesStub
        return imageView
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupPlaceholderLabelConstraints()
        setupNavigationButtonConstraints()
        setupPlaceholderImageViewConstraints()
        setupAccessability()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(placeholderLabel)
        view.addSubview(placeholderImageView)
        view.addSubview(navigationButton)
    }
    
    private func setupAccessability() {
        isAccessibilityElement = true
        view.accessibilityIdentifier = "favorites_placeholder"
        
        placeholderLabel.isAccessibilityElement = true
        placeholderLabel.accessibilityIdentifier = "favorites_placeholder_label"
        
        navigationButton.isAccessibilityElement = true
        navigationButton.accessibilityIdentifier = "favorites_placeholder_navigation"
        
        placeholderImageView.isAccessibilityElement = true
        placeholderImageView.accessibilityIdentifier = "favorites_placeholder_imageView"
    }
    
    private func setupPlaceholderLabelConstraints() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupNavigationButtonConstraints() {
        navigationButton.translatesAutoresizingMaskIntoConstraints = false
        navigationButton.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: 13).isActive = true
        navigationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupPlaceholderImageViewConstraints() {
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.heightAnchor.constraint(equalToConstant: 193).isActive = true
        placeholderImageView.widthAnchor.constraint(equalToConstant: 248).isActive = true
        placeholderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        placeholderImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
