//
//  Coordinator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 31.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Координатор приложения
protocol Coordinator: class {
    
    /// Дочерние координаторы
    var childCoordinators: [Coordinator] { get set }
    
    /// NavigationController для ViewController'ов координатора
    var navigationController: UINavigationController { get set }

    /// Начальная установка координатора
    func start()
}

/// Отображение детальной информации о фильме
protocol SearchCoordinator: class {
    
    /// Показывает экран детальной информации о фильме
    ///
    /// - Parameters:
    ///   - data: Данные из ячейки в CollectionView на которую нажали.
    func showMovieDetails(data: MovieDetails)
}
