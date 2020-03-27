//
//  XCTestCaseExtension.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 26.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func assertGet(request: URLRequest) {
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertNil(request.httpBody)
    }
    
    func assertPost(request: URLRequest) {
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertNotNil(request.httpBody)
    }
    
    func assertDelete(request: URLRequest) {
        XCTAssertEqual(request.httpMethod, "DELETE")
        XCTAssertNotNil(request.httpBody)
    }
}
