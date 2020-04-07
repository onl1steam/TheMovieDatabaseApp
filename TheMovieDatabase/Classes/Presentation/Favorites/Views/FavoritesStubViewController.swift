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
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = FavoritesScreenStrings.blankListLabel
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .customLight
        return label
    }()
    
    private lazy var navigationButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.customPurpure, for: .normal)
        button.setTitle(FavoritesScreenStrings.searchFilmsButtonText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(nil, action: #selector(searchTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .favoritesStub
        return imageView
    }()
    
    weak var delegate: FavoritesViewControllerDelegate?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupPlaceholderLabelConstraints()
        setupNavigationButtonConstraints()
        setupPlaceholderImageViewConstraints()
        setupAccessability()
    }
    
    // MARK: - IBActions
    
    @objc private func searchTapped() {
        delegate?.searchTapped()
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
        navigationButton.constraintStringMainView(sideMargin: 0, topMargin: 0, parentView: view)
    }
    
    private func setupNavigationButtonConstraints() {
        navigationButton.constraintStringViewWithTopView(
            sideMargin: 0,
            topMargin: 13,
            parentView: view,
            topView: placeholderLabel)
    }
    
    private func setupPlaceholderImageViewConstraints() {
        placeholderImageView.constraintMiddle(parentView: view)
        placeholderImageView.constraintRectangle(width: 248, height: 193)
    }
}
