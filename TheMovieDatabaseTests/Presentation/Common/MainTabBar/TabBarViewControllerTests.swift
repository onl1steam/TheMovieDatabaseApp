//
//  TabBarViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class TabBarViewControllerTests: ViewControllerTestCase {
    
    // MARK: - Public Properties

    var viewController: TabBarViewController { rootViewController as! TabBarViewController }
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        let tabBarVC = TabBarViewController()
        rootViewController = tabBarVC
    }
    
    // MARK: - Tests
    
    func testTabBarItemsCount() {
        XCTAssertNotNil(viewController.tabBar.items)
        XCTAssertEqual(viewController.tabBar.items?.count, 3)
    }
    
    func testTabBarItemsLabel() {
        XCTAssertEqual(viewController.tabBar.items?[0].title, "Фильмы")
        XCTAssertEqual(viewController.tabBar.items?[1].title, "Избранное")
        XCTAssertEqual(viewController.tabBar.items?[2].title, "Профиль")
    }
    
    func testTabBarItemsImagesNotNil() {
        XCTAssertNotNil(viewController.tabBar.items?[0].image)
        XCTAssertNotNil(viewController.tabBar.items?[1].image)
        XCTAssertNotNil(viewController.tabBar.items?[2].image)
    }
}
