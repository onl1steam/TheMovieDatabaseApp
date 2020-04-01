//
//  ImageCacheTests.swift
//  TheMovieDatabaseAPITests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class ImageCacheTests: XCTestCase {
    
    var imageCache: ImageCache!

    override func setUp() {
        super.setUp()
        imageCache = ImageCache()
    }

    func testCachingImage() {
        let data = UIImage()
        imageCache.cacheImage(key: "Foo", image: data)
        XCTAssertNotNil(imageCache.checkImageInCache(key: "Foo"))
    }

    func testDeletingImageFromCache() {
        let data = UIImage()
        imageCache.cacheImage(key: "Foo", image: data)
        imageCache.deleteFromCache(key: "Foo")
        XCTAssertNil(imageCache.checkImageInCache(key: "Foo"))
    }
}
