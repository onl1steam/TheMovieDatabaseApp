//
//  FadeAnimator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 05.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Анимация перехода экранов с исчезанием экрана
final class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Public Properties
    
    let presenting: Bool
    
    // MARK: - Initializers
    
    init(presenting: Bool) {
        self.presenting = presenting
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        let duration: TimeInterval = 0.5
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let container = transitionContext.containerView
        if presenting {
            container.addSubview(toView)
            toView.alpha = 0.0
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                if self.presenting {
                    toView.alpha = 1.0
                } else {
                    fromView.alpha = 0.0
                }
            },
            completion: { _ in
                let success = !transitionContext.transitionWasCancelled
                if !success {
                    toView.removeFromSuperview()
                }
                transitionContext.completeTransition(success)
            })
    }
}
