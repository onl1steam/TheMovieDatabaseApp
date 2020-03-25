//
//  AccountViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class AccountViewControllerTests: ViewControllerTestCase {
    
    var viewController: AccountViewController { rootViewController as! AccountViewController }
    
    override func setUp() {
        super.setUp()
        let accountVC = AccountViewController(
            sessionService: SessionServiceMock(),
            imageService: ImageServiceMock())
        rootViewController = accountVC
    }
    
    func testLoadingAccountAvatar() {
        viewController.loadAccountInfo()
        XCTAssertNotNil(viewController.avatarImageView.image)
    }
    
    func testLoadingAccountInfo() {
        viewController.loadAccountInfo()
        XCTAssertEqual(viewController.nameLabel.text, "onl1steam")
        XCTAssertEqual(viewController.emailLabel.text, "Artem")
    }
    
    func testDeletingAccountSessionWithError() {
        viewController.logout()
        XCTAssertEqual(viewController.errorLabel.text, "Не удалось деавторизоваться.")
    }
    
    func testShowingError() {
        let errorMessage = "Test Error"
        viewController.showError(message: errorMessage)
        XCTAssertEqual(viewController.errorLabel.text, errorMessage)
    }
}
