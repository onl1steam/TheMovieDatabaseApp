//
//  ImageCache.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class ImageCache {
    
    // MARK: - Private Properties
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Public methods
    
    func checkImageInCache(key: String) -> UIImage? {
        let imageKey = NSString(string: key)
        guard let image = imageCache.object(forKey: imageKey) else { return nil }
        return image
    }
    
    func cacheImage(key: String, image: UIImage) {
        let imageKey = NSString(string: key)
        imageCache.setObject(image, forKey: imageKey)
    }
    
    func deleteFromCache(key: String) {
        let imageKey = NSString(string: key)
        imageCache.removeObject(forKey: imageKey)
    }
}
