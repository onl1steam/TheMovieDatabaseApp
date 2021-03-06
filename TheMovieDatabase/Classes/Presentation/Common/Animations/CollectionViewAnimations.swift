//
//  CollectionViewAnimations.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 05.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Анимации с коллекцией фильмов
final class CollectionViewAnimations {
    
    private enum CollectionViewAnimationConstants {
        static var duration: TimeInterval = 0.4
    }
    
    private enum ShakeAnimationConstants {
        static let duration: CFTimeInterval = 0.07
        static let repeatCount: Float = 3
        static let autoreverses: Bool = true
        static let shakingMargin: CGFloat = 10
    }
    
    /// Анимированно изменяет Collection View Layout
    ///
    /// - Parameters:
    ///     - collectionView: CollectionView, на котором применяется анимация
    static func collectionViewAnimation(collectionView: UICollectionView) {
        UIView.transition(
            with: collectionView,
            duration: CollectionViewAnimationConstants.duration,
            options: .transitionCrossDissolve,
            animations: {
                collectionView.reloadData()
            },
            completion: nil)
    }
}
