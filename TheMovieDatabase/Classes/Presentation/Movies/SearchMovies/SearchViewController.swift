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
    let moviesCollectionViewController = MoviesCollectionViewController(
        collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Private Properties
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var searchBar: CustomSearchBar = {
        let rect = CGRect(x: 0, y: 0, width: 280, height: 48)
        let searchBar = CustomSearchBar(frame: rect)
        return searchBar
    }()
    
    private lazy var appearanceButton: UIButton = {
        let button = UIButton()
        button.setImage(.listButton, for: .normal)
        button.tintColor = .customLight
        return button
    }()
    
    private let searchStubViewController = SearchStubViewController()
    private var collectionPresentation: CollectionPresentation = .verticalCell
    
    // MARK: - Initializers
    
    init(moviesService: MoviesServiceType = ServiceLayer.shared.moviesService) {
        self.moviesService = moviesService
        super.init(nibName: nil, bundle: nil)
        moviesCollectionViewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .backgroundBlack
        searchBar.searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        appearanceButton.addTarget(self, action: #selector(changeAppearance(_:)), for: .touchUpInside)
        setupContainerConstraints()
        navigationController?.navigationBar.removeBottomLine()
    }
    
    // MARK: - IBActions
    
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
    
    @objc private func searchTextChanged() {
        guard let text = searchBar.searchTextField.text, text != "" else {
            removeChild(moviesCollectionViewController, containerView: containerView)
            addChild(searchStubViewController, containerView: containerView)
            return
        }
        loadMovieList(text: text)
    }
    
    // MARK: - Private Methods
    
    private func loadMovieList(text: String) {
        moviesCollectionViewController.setCollectionData([])
        moviesCollectionViewController.toggleIndicator()
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
            removeChild(moviesCollectionViewController, containerView: containerView)
            addChild(searchStubViewController, containerView: containerView)
            return
        }
        
        moviesService.movieListDetails(movieList: movieList) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let detailsList):
                self.removeChild(self.searchStubViewController, containerView: self.containerView)
                self.addChild(self.moviesCollectionViewController, containerView: self.containerView)
                self.moviesCollectionViewController.setCollectionData(detailsList)
                self.moviesCollectionViewController.toggleIndicator()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupBarItems() {
        navigationItem.titleView = searchBar
        
        let listItem = UIBarButtonItem(customView: appearanceButton)
        self.navigationItem.rightBarButtonItems =  [listItem]
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .backgroundBlack
        navigationController?.navigationBar.barTintColor = .backgroundBlack
        setupBarItems()
    }
    
    private func setupContainerConstraints() {
        view.addSubview(containerView)
        containerView.constraintContainer(
            sideMargin: 24,
            topMargin: 40,
            bottomMargin: 0,
            parentView: view)
    }
}

// MARK: - CollectionParentDelegate

extension SearchViewController: CollectionParentDelegate {
    
    func elementTapped(data: MovieDetails) {
        delegate?.showMovieDetails(movieData: data)
    }
}
