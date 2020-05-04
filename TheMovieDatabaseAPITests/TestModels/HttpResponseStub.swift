//
//  HttpResponseStub.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 26.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    static func stub(statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "http://test")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
