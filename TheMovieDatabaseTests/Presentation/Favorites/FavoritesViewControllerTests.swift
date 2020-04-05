//
//  FavoritesViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class FavoritesViewControllerTests: ViewControllerTestCase {
    
    // MARK: - Public Properties

    var viewController: FavoritesViewController { rootViewController as! FavoritesViewController }
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        let favoritesVC = FavoritesViewController(sessionService: SessionServiceMock())
        rootViewController = favoritesVC
    }
    
    // MARK: - Tests
    
//    func testPlaceholderAtStart() {
//        let placeholderViewController = viewController.placeholderViewController
//        XCTAssertEqual(placeholderViewController.placeholderLabel.text, "Вы не добавили ни одного фильма")
//        XCTAssertNotNil(placeholderViewController.placeholderImageView.image)
//        XCTAssertEqual(placeholderViewController.navigationButton.titleLabel?.text, "Найти любимые фильмы")
//    }
//
//    func testLabelAtStart() {
//        XCTAssertEqual(viewController.favoriteLabel.text, "Избранное")
//    }
}
