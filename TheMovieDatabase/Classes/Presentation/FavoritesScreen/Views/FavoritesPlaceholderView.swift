//
//  FavoritesPlaceholderView.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class FavoritesPlaceholderView: UIView {
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = FavoritesScreenStrings.blankListLabel
        label.textColor = Colors.light
        return label
    }()
    
    let navigationButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.purpure, for: .normal)
        button.setTitle(FavoritesScreenStrings.searchFilmsButtonText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let placeholderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.favoritesBackground
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupPlaceholderLabelConstraints()
        setupNavigationButtonConstraints()
        setupPlaceholderImageViewConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(placeholderLabel)
        addSubview(placeholderImageView)
        addSubview(navigationButton)
    }
    
    private func setupPlaceholderLabelConstraints() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24).isActive = true
    }
    
    private func setupNavigationButtonConstraints() {
        navigationButton.translatesAutoresizingMaskIntoConstraints = false
        navigationButton.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: 13).isActive = true
        navigationButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        navigationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24).isActive = true
    }
    
    private func setupPlaceholderImageViewConstraints() {
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.topAnchor.constraint(equalTo: navigationButton.topAnchor, constant: 88).isActive = true
        placeholderImageView.heightAnchor.constraint(equalToConstant: 193).isActive = true
        placeholderImageView.widthAnchor.constraint(equalToConstant: 248).isActive = true
        placeholderImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
