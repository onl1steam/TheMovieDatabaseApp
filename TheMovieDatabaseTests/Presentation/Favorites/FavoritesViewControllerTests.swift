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

    var viewController: FavoritesViewController { rootViewController as! FavoritesViewController }
    var placeholderView: FavoritesPlaceholderView? { subview(with: "favorites_placeholder") }
    
    override func setUp() {
        super.setUp()
        let favoritesVC = FavoritesViewController(sessionService: SessionServiceMock())
        rootViewController = favoritesVC
    }
    
    func testPlaceholderAtStart() {
        XCTAssertEqual(placeholderView?.placeholderLabel.text, "Вы не добавили ни одного фильма")
        XCTAssertNotNil(placeholderView?.placeholderImageView.image)
        XCTAssertEqual(placeholderView?.navigationButton.titleLabel?.text, "Найти любимые фильмы")
    }

    func testLabelAtStart() {
        XCTAssertEqual(viewController.favoriteLabel.text, "Избранное")
    }
}
