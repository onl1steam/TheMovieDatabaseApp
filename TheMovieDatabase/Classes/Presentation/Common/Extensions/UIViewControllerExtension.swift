//
//  UIViewControllerExtension.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 09.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
    
    /// Добавить ChildViewController на экран в ContainerView.
    ///
    /// - Parameters:
    ///     - child: ChildViewController, который необходимо отобразить.
    ///     - containerView: View, на котором отображается ChildViewController.
    func addChild(_ child: UIViewController, containerView: UIView) {
        child.view.frame.size = containerView.bounds.size
        addChild(child)
        containerView.addSubview(child.view)
        didMove(toParent: self)
    }
    
    /// Добавить ChildViewController на экран из ContainerView.
    ///
    /// - Parameters:
    ///     - child: ChildViewController, который необходимо убрать.
    ///     - containerView: View, на котором отображается ChildViewController.
    func removeChild(_ child: UIViewController, containerView: UIView) {
        child.willMove(toParent: self)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
