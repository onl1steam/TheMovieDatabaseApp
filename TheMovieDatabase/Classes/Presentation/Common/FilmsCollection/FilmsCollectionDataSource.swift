//
//  FilmsCollectionDataSource.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class FilmsCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Public Properties

    var moviesData = [MovieDetails]()
    
    // MARK: - Private Properties
    
    private var reuseIdentifier = "FilmsCollectionViewCell"
    
    // MARK: - Initializers
    
    init(data: [MovieDetails]) {
        moviesData = data
        super.init()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = moviesData.count
        return count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? FilmsCollectionViewCell else { fatalError("Неправильная ячейка") }
        
        let data = moviesData[indexPath.row]
        cell.configure(data: data)
        return cell
    }
    
    // MARK: - Public Methods
    
    func update(with data: [MovieDetails]) {
        moviesData = data
    }
}
