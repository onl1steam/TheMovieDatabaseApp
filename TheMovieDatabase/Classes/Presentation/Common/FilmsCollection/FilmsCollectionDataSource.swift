//
//  FilmsCollectionDataSource.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class FilmsCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    private var reuseIdentifier = "FilmsCollectionViewCell"
    var moviesData = [MovieDetails]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = moviesData.count
        return count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FilmsCollectionViewCell
        let data = moviesData[indexPath.row]
        cell.configure(data: data)
        return cell
    }
    
}
