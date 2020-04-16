//
//  FavoritesViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Делегат для связи с Child ViewController'ами
protocol FavoritesViewControllerDelegate: AnyObject {
    
    /// Нажатие кнопки поиска
    func searchTapped()
}

final class FavoritesViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var favoriteLabel: UILabel!
    @IBOutlet private var containerView: UIView!
    
    // MARK: - Public Properties
    
    let sessionService: Session
    let moviesService: MoviesServiceType
    let databaseService: DatabaseServiceType
    
    let moviesCollectionViewController = MoviesCollectionViewController(
        collectionViewLayout: UICollectionViewFlowLayout())
    let placeholderViewController = FavoritesStubViewController()
    
    weak var delegate: FavoritesCoordinatorType?
    
    // MARK: - Private Properties
    
    private var collectionPresentation: CollectionPresentation = .verticalCell
    
    private lazy var appearanceButton: UIButton = {
        let button = UIButton()
        button.setImage(.listButton, for: .normal)
        button.tintColor = .customLight
        return button
    }()
    
    private lazy var searchBar: CustomSearchBar = {
        let rect = CGRect(x: 0, y: 0, width: 280, height: 48)
        let searchBar = CustomSearchBar(frame: rect)
        searchBar.alpha = 0
        return searchBar
    }()
    
    // MARK: - Initializers
    
    init(
        sessionService: Session = ServiceLayer.shared.sessionService,
        moviesService: MoviesServiceType = ServiceLayer.shared.moviesService,
        databaseService: DatabaseServiceType = ServiceLayer.shared.databaseService) {
        self.sessionService = sessionService
        self.moviesService = moviesService
        self.databaseService = databaseService
        super.init(nibName: nil, bundle: nil)
        placeholderViewController.delegate = self
        moviesCollectionViewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        appearanceButton.addTarget(self, action: #selector(changeAppearance(_:)), for: .touchUpInside)
        setupColorScheme()
        setupLocalizedStrings()
        setupNavigationBar()
        fetchMovies()
        navigationController?.navigationBar.removeBottomLine()
    }
    
    // MARK: - IBAction
    
    @objc private func searchButtonTapped(_ sender: UIBarButtonItem) {
        searchBar.endEditing(false)
        UIView.animate(withDuration: 0.5) {
            if self.searchBar.alpha == 0 {
                self.searchBar.alpha = 1
            } else {
                self.searchBar.alpha = 0
            }
        }
    }
    
    @objc private func changeAppearance(_ sender: UIButton) {
        switch collectionPresentation {
        case .horizontalCell:
            sender.setImage(.listButton, for: .normal)
            collectionPresentation = .verticalCell
        case .verticalCell:
            sender.setImage(.widgetsButton, for: .normal)
            collectionPresentation = .horizontalCell
        }
        moviesCollectionViewController.updateCellPresentation(presentation: collectionPresentation)
    }
    
    // MARK: - Private Methods
    
    private func saveMovies(_ movieDetails: [MovieDetails]) {
        databaseService.saveMovieDetails(movieDetails)
    }
    
    private func fetchMovies() {
        self.removeChild(self.placeholderViewController, containerView: self.containerView)
        self.addChild(self.moviesCollectionViewController, containerView: self.containerView)
        
        let movieDetails = databaseService.fetchMovieDetails()
        moviesCollectionViewController.setCollectionData(movieDetails)
        loadMovieList()
    }
    
    private func loadMovieList() {
        self.removeChild(self.placeholderViewController, containerView: self.containerView)
        self.addChild(self.moviesCollectionViewController, containerView: self.containerView)
        moviesCollectionViewController.toggleIndicator(true)
        sessionService.favoriteMovies(language: "ru", sortBy: nil, page: nil) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let movieList):
                self.loadMovieDetails(movieList: movieList.results)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadMovieDetails(movieList: [MovieList.MoviesResult]) {
        guard !movieList.isEmpty else {
            removeChild(moviesCollectionViewController, containerView: containerView)
            addChild(placeholderViewController, containerView: containerView)
            return
        }
        
        moviesService.movieListDetails(movieList: movieList) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let detailsList):
                self.removeChild(self.placeholderViewController, containerView: self.containerView)
                self.addChild(self.moviesCollectionViewController, containerView: self.containerView)
                self.moviesCollectionViewController.setCollectionData(detailsList)
                self.saveMovies(detailsList)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            self.moviesCollectionViewController.toggleIndicator(false)
        }
    }
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
        favoriteLabel.tintColor = .customLight
    }
    
    private func setupLocalizedStrings() {
        favoriteLabel.text = FavoritesScreenStrings.favoriteLabel
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .backgroundBlack
        navigationController?.navigationBar.barTintColor = .backgroundBlack
        setupBarItems()
    }
    
    private func setupBarItems() {
        navigationItem.titleView = searchBar
        let listItem = UIBarButtonItem(customView: appearanceButton)
        let searchItem = UIBarButtonItem(
            image: .search,
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped(_:)))
        searchItem.tintColor = .customLight
        self.navigationItem.rightBarButtonItems =  [listItem, searchItem]
    }
}

// MARK: - FavoritesViewControllerDelegate

extension FavoritesViewController: FavoritesViewControllerDelegate {
    
    func searchTapped() {
        
    }
}

// MARK: - CollectionParentDelegate

extension FavoritesViewController: CollectionParentDelegate {
    
    func elementTapped(data: MovieDetails) {
        delegate?.showMovieDetails(movieData: data)
    }
}

// MARK: - UISearchBarDelegate

extension FavoritesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        moviesCollectionViewController.filterMovies(searchString: searchBar.text)
    }
}
