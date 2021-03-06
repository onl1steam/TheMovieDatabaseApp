//
//  Animations.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 04.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Анимации для различных View
final class ViewAnimations {
    
    private enum SizeAnimationConstants {
        static var duration: TimeInterval = 0.2
        static var delay: TimeInterval = 0
        static var transformScale: CGFloat = 1.1
        static var initialScale: CGFloat = 1
    }
    
    private enum ShakeAnimationConstants {
        static let duration: CFTimeInterval = 0.07
        static let repeatCount: Float = 3
        static let autoreverses: Bool = true
        static let shakingMargin: CGFloat = 10
    }
    
    /// Анимация дрожания View
    ///
    /// - Parameters:
    ///     - view: View, на котором применяется анимация
    static func shakeAnimation(on view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = ShakeAnimationConstants.duration
        animation.repeatCount = ShakeAnimationConstants.repeatCount
        animation.autoreverses = ShakeAnimationConstants.autoreverses
        animation.fromValue = CGPoint(x: view.center.x - ShakeAnimationConstants.shakingMargin, y: view.center.y)
        animation.toValue = CGPoint(x: view.center.x + ShakeAnimationConstants.shakingMargin, y: view.center.y)
        
        view.layer.add(animation, forKey: "position")
    }
    
    /// Анимация увеличения и обратного уменьшения View
    ///
    /// - Parameters:
    ///     - view: View, на котором применяется анимация
    static func zoomInOut(on view: UIView) {
        zoomIn(on: view) { _ in
            zoomOut(on: view)
        }
    }
    
    /// Анимированно изменяет View после добавления констрейтов
    ///
    /// - Parameters:
    ///     - view: View, на котором применяется анимация
    ///     - duration: длительность анимации
    ///     - completion: замыкание, которое нужно выполнить перед обновлением View
    static func animateConstraintChange(view: UIView, duration: CFTimeInterval, completion: (() -> Void)) {
        completion()
        UIView.animate(withDuration: duration) {
            view.layoutIfNeeded()
        }
    }
    
    private static func zoomIn(on view: UIView, completion: @escaping ((Bool) -> Void) ) {
        UIView.animate(
            withDuration: SizeAnimationConstants.duration,
            delay: SizeAnimationConstants.delay,
            options: [.curveEaseOut],
            animations: {
                view.transform = CGAffineTransform(
                    scaleX: SizeAnimationConstants.transformScale,
                    y: SizeAnimationConstants.transformScale)
            },
            completion: completion)
    }
    
    private static func zoomOut(on view: UIView) {
        UIView.animate(
            withDuration: SizeAnimationConstants.duration,
            delay: SizeAnimationConstants.delay,
            options: [.curveEaseOut],
            animations: {
                view.transform = CGAffineTransform(
                    scaleX: SizeAnimationConstants.initialScale,
                    y: SizeAnimationConstants.initialScale)
            },
            completion: nil)
    }
}
