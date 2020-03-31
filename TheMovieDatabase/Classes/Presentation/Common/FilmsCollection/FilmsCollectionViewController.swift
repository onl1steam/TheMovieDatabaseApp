//
//  FilmsCollectionViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class FilmsCollectionViewController: UICollectionViewController {
    
    // MARK: - Public Properties
    
    var moviesData = [MovieDetails]()
    var dataSource: FilmsCollectionDataSource?
    
    // MARK: - Private Properties
    
    private let reuseIdentifier = "FilmsCollectionViewCell"
    
    // MARK: - UICollectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        configureCell()
        configureDataSource()
        collectionView.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("CollectionView tapped")
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        collectionView.backgroundColor = .backgroundBlack
        view.backgroundColor = .backgroundBlack
    }
    
    private func configureDataSource() {
        dataSource = FilmsCollectionDataSource(data: moviesData)
        collectionView.dataSource = dataSource
    }
    
    private func configureCell() {
        let nib = UINib(nibName: "FilmsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FilmsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 310)
    }
}