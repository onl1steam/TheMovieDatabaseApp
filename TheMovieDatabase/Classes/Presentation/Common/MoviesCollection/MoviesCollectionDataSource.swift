//
//  MoviesCollectionDataSource.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// DataSource для коллекции списка фильмов
final class MoviesCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    private enum Constants {
        static let cellError: String = "Неправильная ячейка"
    }
    
    // MARK: - Public Properties
    
    var moviesData = [MovieDetails]()
    let imageService: ImageServiceType
    
    // MARK: - Initializers
    
    init(data: [MovieDetails], imageService: ImageServiceType = ServiceLayer.shared.imageService) {
        moviesData = data
        self.imageService = imageService
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
            withReuseIdentifier: MoviesCollectionViewCell().identifier,
            for: indexPath) as? MoviesCollectionViewCell
            else {
                fatalError(Constants.cellError)
        }
        
        let movie = moviesData[indexPath.row]
        cell.configure(movie: movie)
        
        if let path = movie.posterPath {
            cell.toggleActivityIndicator()
            imageService.image(posterPath: path, width: nil) { response in
                switch response {
                case .success(let image):
                    cell.setupImage(image)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
                cell.toggleActivityIndicator()
            }
        }
        return cell
    }
    
    // MARK: - Public Methods
    
    /// Обновить список фильмов в коллекции
    ///
    /// - Parameters:
    ///     - moviesDetails: список фильмов.
    func update(with moviesDetails: [MovieDetails]) {
        self.moviesData = moviesDetails
    }
}
