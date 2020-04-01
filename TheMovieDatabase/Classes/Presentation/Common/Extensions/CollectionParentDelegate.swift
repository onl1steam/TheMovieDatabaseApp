//
//  CollectionParentDelegate.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 01.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Делегат родительского ViewController'а для коллекции фильмов
protocol CollectionParentDelegate: class {
    
    /// Обработка нажатия на элемент коллекции
    func elementTapped(data: MovieDetails)
}
