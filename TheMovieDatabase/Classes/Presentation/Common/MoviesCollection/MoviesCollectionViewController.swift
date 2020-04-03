//
//  MoviesCollectionViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// ViewController коллекции, отображающей список фильмов
final class MoviesCollectionViewController: UICollectionViewController {
    
    // MARK: - Public Properties
    
    var moviesData = [MovieDetails]()
    var dataSource: MoviesCollectionDataSource?
    weak var delegate: CollectionParentDelegate?
    
    var activityIndicator: UIActivityIndicatorView!
    
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
        guard let movieData = dataSource?.moviesData[indexPath.row] else { return }
        delegate?.elementTapped(data: movieData)
    }
    
    // MARK: - Public Methods
    
    func setCollectionData(_ data: [MovieDetails]) {
        dataSource?.update(with: data)
        collectionView.reloadData()
    }
    
    func toggleIndicator() {
        activityIndicator.isHidden ? activityIndicator.startAnimating(): activityIndicator.stopAnimating()
    }
    
    // MARK: - Private Methods
    
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
        let identifier = MoviesCollectionViewCell().identifier
        let nib = UINib(nibName: identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    private enum CellSize {
        static let width: CGFloat = 150
        static let height: CGFloat = 310
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: CellSize.width, height: CellSize.height)
        return size
    }
}
