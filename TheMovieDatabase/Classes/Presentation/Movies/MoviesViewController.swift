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
    
    @IBOutlet private var moviesBackground: UIImageView!
    @IBOutlet private var moviesLabel: UILabel!
    
    // MARK: - Public Properties
    
    let sessionService: Session
    weak var delegate: MoviesCoordinatorType?
    
    // MARK: - Private Properties
    
    private lazy var moviesSearchBar: CustomSearchBar! = {
        let rect = CGRect(x: 0, y: 0, width: 200, height: 48)
        let customBar = CustomSearchBar(frame: rect)
        return customBar
    }()
    
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
        setupLocalizedStrings()
        setupSearchBarConstraints()
        moviesSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
        moviesLabel.tintColor = .customLight
    }
    
    private func setupLocalizedStrings() {
        moviesLabel.text = MoviesScreenStrings.moviesLabel
        moviesSearchBar.placeholder = MoviesScreenStrings.searchBarPlaceholder
    }
    
    private func setupSearchBarConstraints() {
        view.addSubview(moviesSearchBar)
        moviesSearchBar.constraintRectangle(width: 280, height: 48)
        let topConstraint = moviesSearchBar.topAnchor.constraint(equalTo: moviesLabel.bottomAnchor, constant: 33)
        let leadingConstraint = moviesSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint])
    }
}

// MARK: - UISearchBarDelegate

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchBarTapped()
    }
}
