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
    
    let imageService: ImageServiceType
    
    // MARK: - Private Properties
    
    private var reuseIdentifier = "FilmsCollectionViewCell"
    
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
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? FilmsCollectionViewCell else { fatalError("Неправильная ячейка") }
        
        let data = moviesData[indexPath.row]
        cell.configure(data: data)
        
        if let path = data.posterPath {
            imageService.image(posterPath: path, width: nil) { response in
                switch response {
                case .success(let image):
                    cell.configureImage(image)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        return cell
    }
    
    // MARK: - Public Methods
    
    func update(with data: [MovieDetails]) {
        moviesData = data
    }
}
