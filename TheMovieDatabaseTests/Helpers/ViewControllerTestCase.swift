//
//  ViewControllerTestCase.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import XCTest

class ViewControllerTestCase: XCTestCase {
    
    lazy var window: UIWindow = { UIWindow(frame: UIScreen.main.bounds) }()
    
    var rootViewController: UIViewController? {
        get {
            let windowValue = window.rootViewController
            return windowValue
        }
        set {
            window.rootViewController = newValue
        }
    }
    
    override func setUp() {
        super.setUp()
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }
    
    func subview<T: UIView>(with identifier: String) -> T? {
        rootViewController?.view.subview(withAccessibilityIdentifier: identifier)
    }
}
