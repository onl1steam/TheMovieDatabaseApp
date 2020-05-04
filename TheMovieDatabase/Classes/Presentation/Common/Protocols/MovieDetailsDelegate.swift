//
//  MovieDetailsDelegate.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 02.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

/// Обработка действий с экрана деталей фильма
protocol MovieDetailsDelegate: AnyObject {
    
    /// Обработка нажатия на стрелку назад
    func arrowBackTapped()
    
    /// Обработка нажатия на кнопку избранного
    func favoriteTapped()
}
