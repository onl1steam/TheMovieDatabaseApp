//
//  RoundedButtonViewTests.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

class RoundedButtonViewTests: XCTestCase {
    
    // MARK: - Public Properties

    var roundedButton: RoundedButton!
    
    // MARK: - setUp
    
    override func setUp() {
        super.setUp()
        roundedButton = RoundedButton()
    }
    
    // MARK: - Tests
    
    func testSetupBorderWidth() {
        let borderWidth: CGFloat = 2.0
        roundedButton.borderWidth = borderWidth
        XCTAssertEqual(roundedButton.borderWidth, borderWidth)
    }
    
    func testSetupCornerRadius() {
        let cornerRadius: CGFloat = 2.0
        roundedButton.cornerRadius = cornerRadius
        XCTAssertEqual(roundedButton.cornerRadius, cornerRadius)
    }
    
    func testSetupBorderColor() {
        let borderColor: UIColor = .white
        roundedButton.borderColor = borderColor
        XCTAssertEqual(roundedButton.borderColor, borderColor)
    }
    
}
