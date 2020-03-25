//
//  MoviesViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class MoviesViewControllerTests: ViewControllerTestCase {

    var viewController: MoviesViewController { rootViewController as! MoviesViewController }
    
    override func setUp() {
        super.setUp()
        let moviesVC = MoviesViewController(sessionService: SessionServiceMock())
        rootViewController = moviesVC
    }
    
    func testAppearanceAtStart() {
        XCTAssertEqual(viewController.moviesLabel.text, "Найдем любой фильм на ваш вкуc")
        XCTAssertEqual(viewController.moviesSearchBar.placeholder, "Поиск фильмов")
        XCTAssertNotNil(viewController.moviesBackground.image)
    }
}
