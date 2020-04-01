//
//  FavoritesViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Делегат для связи с Child ViewController'ами
protocol FavoritesViewControllerDelegate: class {
    
    /// Нажатие кнопки поиска
    func searchTapped()
}

final class FavoritesViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Public Properties
    
    let sessionService: Session
    let moviesService: MoviesServiceType
    
    let filmsCollectionVC = FilmsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    let placeholderVC = FavoritesStubViewController()
    
    weak var delegate: FavoritesCoordinatorType?
    
    // MARK: - Initializers
    
    init(
        sessionService: Session = ServiceLayer.shared.sessionService,
        moviesService: MoviesServiceType = ServiceLayer.shared.moviesService) {
        self.sessionService = sessionService
        self.moviesService = moviesService
        super.init(nibName: nil, bundle: nil)
        placeholderVC.delegate = self
        filmsCollectionVC.delegate = self
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
    }
    
    // MARK: - IBAction
    
    @objc func searchButtonTapped() {
        
    }
    
    @objc func changeAppearance(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Private Methods
    
    private func loadFilmList() {
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
            removeChild(filmsCollectionVC, containerView: containerView)
            showChild(placeholderVC, containerView: containerView)
            return
        }
        
        var list = [MovieDetails]()
        
        let group = DispatchGroup()
        movieList.forEach { movie in
            group.enter()
            moviesService.movieDetails(movieId: movie.id, language: "ru") { response in
                switch response {
                case .success(let movieDetails):
                    list.append(movieDetails)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self.placeholderVC, containerView: self.containerView)
            self.showChild(self.filmsCollectionVC, containerView: self.containerView)
            self.filmsCollectionVC.setCollectionData(list)
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
            action: #selector(searchButtonTapped))
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
        delegate?.showMovieDetails(data: data)
    }
}
