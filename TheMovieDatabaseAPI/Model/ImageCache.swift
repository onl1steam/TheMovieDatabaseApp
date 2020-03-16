//
//  ImageCache.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

class ImageCache {
    
    static let shared = ImageCache()
    
    private init() {}
    
    private let imageCache = NSCache<NSString, NSData>()
    
    func checkImageInCache(key: String) -> Data? {
        let imageKey = NSString(string: key)
        guard let imageNSData = imageCache.object(forKey: imageKey) else { return nil }
        let imageData = Data(imageNSData)
        return imageData
    }
    
    func cacheImage(key: String, imageData: Data) {
        let imageNSData = NSData(data: imageData)
        let imageKey = NSString(string: key)
        imageCache.setObject(imageNSData, forKey: imageKey)
    }
    
    func deleteFromCache(key: String) {
        let imageKey = NSString(string: key)
        imageCache.removeObject(forKey: imageKey)
    }
}
