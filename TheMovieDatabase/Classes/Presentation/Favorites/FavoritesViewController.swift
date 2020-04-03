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
    
    let filmsCollectionViewController = MoviesCollectionViewController(
        collectionViewLayout: UICollectionViewFlowLayout())
    let placeholderViewController = FavoritesStubViewController()
    
    weak var delegate: FavoritesCoordinatorType?
    
    // MARK: - Initializers
    
    init(
        sessionService: Session = ServiceLayer.shared.sessionService,
        moviesService: MoviesServiceType = ServiceLayer.shared.moviesService) {
        self.sessionService = sessionService
        self.moviesService = moviesService
        super.init(nibName: nil, bundle: nil)
        placeholderViewController.delegate = self
        filmsCollectionViewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupLocalizedStrings()
        setupNavigationBar()
        loadFilmList()
        navigationController?.navigationBar.removeBottomLine()
    }
    
    // MARK: - IBAction
    
    @objc private func searchButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func changeAppearance(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Private Methods
    
    private func loadFilmList() {
        filmsCollectionViewController.setCollectionData([])
        filmsCollectionViewController.toggleIndicator()
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
            removeChild(filmsCollectionViewController, containerView: containerView)
            addChild(placeholderViewController, containerView: containerView)
            return
        }
        
        moviesService.movieListDetails(movieList: movieList) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let detailsList):
                self.removeChild(self.placeholderViewController, containerView: self.containerView)
                self.addChild(self.filmsCollectionViewController, containerView: self.containerView)
                self.filmsCollectionViewController.setCollectionData(detailsList)
                self.filmsCollectionViewController.toggleIndicator()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
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
        let listItem = UIBarButtonItem(
            image: .listButton,
            style: .plain,
            target: self,
            action: #selector(changeAppearance(_:)))
        listItem.tintColor = .customLight
        let searchItem = UIBarButtonItem(
            image: .search,
            style: .plain,
            target: nil,
            action: #selector(searchButtonTapped(_:)))
        searchItem.tintColor = .customLight
        self.navigationItem.rightBarButtonItems =  [listItem, searchItem]
    }
}

// MARK: - FavoritesViewControllerDelegate

extension FavoritesViewController: FavoritesViewControllerDelegate {
    
    func searchTapped() {
        print("Search text tapped")
    }
}

// MARK: - CollectionParentDelegate

extension FavoritesViewController: CollectionParentDelegate {
    
    func elementTapped(data: MovieDetails) {
        delegate?.showMovieDetails(movieData: data)
    }
}
