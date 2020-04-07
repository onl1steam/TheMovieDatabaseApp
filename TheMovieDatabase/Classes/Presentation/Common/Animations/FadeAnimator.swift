//
//  FadeAnimator.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 05.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
