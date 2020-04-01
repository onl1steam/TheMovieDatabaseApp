//
//  SearchViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 31.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: SearchCoordinator?
    
    let moviesService: MoviesServiceType
    let filmsCollectionVC = FilmsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Private Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let searchBar: CustomSearchBar = {
        let rect = CGRect(x: 0, y: 0, width: 280, height: 48)
        let searchBar = CustomSearchBar(frame: rect)
        return searchBar
    }()
    
    private let searchStubVC = SearchStubViewController()
    
    // MARK: - Initializers
    
    init(moviesService: MoviesServiceType = ServiceLayer.shared.moviesService) {
        self.moviesService = moviesService
        super.init(nibName: nil, bundle: nil)
        filmsCollectionVC.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundBlack
        searchBar.searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        setupNavigationBar()
        setupContainerConstraints()
    }
    
    // MARK: - IBActions
    
    @objc func changeAppearance(_ sender: UIBarButtonItem) {
        
    }
    
    @objc func searchTextChanged() {
        guard let text = searchBar.searchTextField.text, text != "" else {
            removeChild(filmsCollectionVC, containerView: containerView)
            showChild(searchStubVC, containerView: containerView)
            return
        }
        loadFilmList(text: text)
    }
    
    // MARK: - Private Methods
    
    private func loadFilmList(text: String) {
        filmsCollectionVC.setCollectionData([])
        filmsCollectionVC.toggleIndicator()
        moviesService.searchMovies(query: text, page: nil) { [weak self] response in
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
            showChild(searchStubVC, containerView: containerView)
            return
        }
        
        moviesService.movieListDetails(movieList: movieList) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let detailsList):
                self.removeChild(self.searchStubVC, containerView: self.containerView)
                self.showChild(self.filmsCollectionVC, containerView: self.containerView)
                self.filmsCollectionVC.setCollectionData(detailsList)
                self.filmsCollectionVC.toggleIndicator()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupBarItems() {
        navigationItem.titleView = searchBar
        let listItem = UIBarButtonItem(
            image: .listButton,
            style: .plain,
            target: self,
            action: #selector(changeAppearance(_:)))
        listItem.tintColor = .customLight
        self.navigationItem.rightBarButtonItems =  [listItem]
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .backgroundBlack
        navigationController?.navigationBar.barTintColor = .backgroundBlack
        setupBarItems()
    }
    
    private func setupContainerConstraints() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    }
}

// MARK: - CollectionParentDelegate

extension SearchViewController: CollectionParentDelegate {
    
    func elementTapped(data: MovieDetails) {
        delegate?.showMovieDetails(data: data)
    }
}
