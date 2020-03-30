//
//  FilmsCollectionViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class FilmsCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "FilmsCollectionViewCell"
    
    var dataSource: UICollectionViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = FilmsCollectionDataSource()
        
        self.collectionView.register(FilmsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.dataSource = dataSource
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
