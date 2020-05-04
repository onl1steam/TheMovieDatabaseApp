//
//  ResponseStub.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 26.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import XCTest

final class ResponseStub: XCTestCase {
    
    static func stub(name: String) -> Data? {
        let testBundle = Bundle(for: self)
        if let path = testBundle.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                XCTFail("Error: \(error.localizedDescription)")
                return nil
            }
        } else {
            return nil
        }
    }
}
