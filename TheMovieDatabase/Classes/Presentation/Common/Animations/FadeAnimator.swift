//
//  FadeAnimator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 05.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let presenting: Bool
    
    init(presenting: Bool) {
        self.presenting = presenting
    }
    
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
