//
//  MoviesViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var moviesSearchBar: CustomSearchBar!
    @IBOutlet weak var moviesLabel: UILabel!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupSearchBar()
        setupLocalizedStrings()
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = Colors.backgroundBlack
        moviesLabel.tintColor = Colors.light
    }

    private func setupLocalizedStrings() {
        moviesLabel.text = MoviesScreenStrings.moviesLabel
        moviesSearchBar.placeholder = MoviesScreenStrings.searchBarPlaceholder
    }
    
    private func setupSearchBar() {
        moviesSearchBar.configure()
    }
}
