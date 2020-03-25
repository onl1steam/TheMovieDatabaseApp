//
//  ImageServiceMock.swift
//  TheMovieDatabaseTests
//
//  Created by Рыжков Артем on 25.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase

final class ImageServiceMock: ImageServiceType {
    
    func image(
        posterPath: String,
        width: String?,
        _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress {
        
        let data = Data()
        completion(.success(data))
        return Progress()
    }
    
    func avatar(
        avatarPath: String,
        _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress {
        
        let data = Data()
        completion(.success(data))
        return Progress()
    }
}
