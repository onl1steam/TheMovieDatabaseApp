//
//  MoviesCollectionViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class MoviesCollectionViewController: UICollectionViewController {
    
    // MARK: - Public Properties
    
    var moviesData = [MovieDetails]()
    var dataSource: MoviesCollectionDataSource?
    weak var delegate: CollectionParentDelegate?
    
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    
    private let reuseIdentifier = "MoviesCollectionViewCell"
    
    // MARK: - UICollectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(style: .white)
        configureDataSource()
        collectionView.delegate = self
        setupColorScheme()
        registerCell()
        setupActivityIndicator()
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
        let isHidden = activityIndicator.isHidden
        if isHidden {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.tintColor = .customLight
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
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
        let nib = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 150, height: 310)
        return size
    }
}