//
//  MoviesCollectionViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

enum CollectionPresentation: String {
    
    case verticalCell = "MoviesCollectionViewVericalCell"
    case horizontalCell = "MoviesCollectionViewHorizontalCell"
}

/// ViewController коллекции, отображающей список фильмов
final class MoviesCollectionViewController: UICollectionViewController {
    
    // MARK: - Public Properties
    
    var moviesData = [MovieDetails]()
    var dataSource: MoviesCollectionDataSource?
    weak var delegate: CollectionParentDelegate?
    
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    
    private var cellIdentifier: CollectionPresentation = .verticalCell
    
    // MARK: - UICollectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupActivityIndicatorConstraints()
        configureDataSource()
        setupCollectionView()
        setupColorScheme()
        registerCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieData = dataSource?.moviesData[safeIndex: indexPath.row] else { return }
        delegate?.elementTapped(data: movieData)
    }
    
    // MARK: - Public Methods
    
    func filterMovies(searchString: String?) {
        guard let searchText = searchString, searchText != "" else {
            setCollectionData(moviesData)
            return
        }
        let movies = moviesData.filter { $0.title.contains(searchText) }
        updateMoviesData(movies)
    }
    
    func setCollectionData(_ moviesData: [MovieDetails]) {
        self.moviesData = moviesData
        dataSource?.update(with: moviesData)
        collectionView.reloadData()
    }
    
    func toggleIndicator() {
        activityIndicator.isHidden ? activityIndicator.startAnimating(): activityIndicator.stopAnimating()
    }
    
    func updateCellPresentation(presentation: CollectionPresentation) {
        cellIdentifier = presentation
        dataSource?.updateCellPresentation(presentation: presentation)
        registerCell()
        CollectionViewAnimations.collectionViewAnimation(collectionView: collectionView)
    }
    
    // MARK: - Private Methods
    
    private func updateMoviesData(_ moviesData: [MovieDetails]) {
        dataSource?.update(with: moviesData)
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = .customLight
        activityIndicator.isHidden = true
    }
    
    private func setupActivityIndicatorConstraints() {
        view.addSubview(activityIndicator)
        activityIndicator.constraintMiddle(parentView: view)
        activityIndicator.constraintRectangle(width: 20, height: 20)
    }
    
    private func setupColorScheme() {
        collectionView.backgroundColor = .backgroundBlack
        view.backgroundColor = .backgroundBlack
    }
    
    private func configureDataSource() {
        dataSource = MoviesCollectionDataSource(data: moviesData)
        collectionView.dataSource = dataSource
    }
    
    private func registerCell() {
        let nibVertical = UINib(nibName: CollectionPresentation.verticalCell.rawValue, bundle: nil)
        let nibHorizontal = UINib(nibName: CollectionPresentation.horizontalCell.rawValue, bundle: nil)
        collectionView.register(
            nibHorizontal,
            forCellWithReuseIdentifier: CollectionPresentation.horizontalCell.rawValue)
        collectionView.register(
            nibVertical,
            forCellWithReuseIdentifier: CollectionPresentation.verticalCell.rawValue)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    private enum CellSize {
        static let verticalCellWidth: CGFloat = 150
        static let verticalCellHeight: CGFloat = 310
        static let horizontalCellWidth: CGFloat = 328
        static let horizontalCellHeight: CGFloat = 96
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = CGSize()
        switch cellIdentifier {
        case .horizontalCell:
            size = CGSize(width: CellSize.horizontalCellWidth, height: CellSize.horizontalCellHeight)
        case .verticalCell:
            size = CGSize(width: CellSize.verticalCellWidth, height: CellSize.verticalCellHeight)
        }
        return size
    }
}
