//
//  MoviesViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var moviesSearchBar: CustomSearchBar!
    @IBOutlet weak var moviesLabel: UILabel!
    
    // MARK: - Public Properties
    
    let sessionService: Session
    
    // MARK: - Initializers
    
    init(sessionService: Session = ServiceLayer.shared.sessionService) {
        self.sessionService = sessionService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
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
