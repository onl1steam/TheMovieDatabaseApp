//
//  MoviesViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesSearchBar: CustomSearchBar!
    @IBOutlet weak var moviesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupLocalizedStrings()
    }

    private func setupLocalizedStrings() {
        moviesLabel.text = MoviesScreenStrings.moviesLabel
        moviesSearchBar.placeholder = MoviesScreenStrings.searchBarPlaceholder
    }
    
    func setupSearchBar() {
        moviesSearchBar.configure()
    }
}