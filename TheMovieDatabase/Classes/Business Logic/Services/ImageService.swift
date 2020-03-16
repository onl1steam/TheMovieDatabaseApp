//
//  ImageService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

protocol ImageServiceType {
    
    @discardableResult
    func getImage(posterPath: String, width: String?, _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress
    
    @discardableResult
    func getAvatar(avatarPath: String, _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress
}

class ImageService: ImageServiceType {
    
    let imageBaseUrl = NetworkConfiguration.imageBaseURL
    let avatarBaseUrl = NetworkConfiguration.avatarBaseURL
    let imageApiClient: APIClient
    
    init(imageApiClient: APIClient = APIRequestImage()) {
        self.imageApiClient = imageApiClient
    }
    
    @discardableResult
    func getImage(
        posterPath: String,
        width: String?,
        _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress {
        let endpoint = ImageEndpoint(baseURL: imageBaseUrl, width: width, imagePath: posterPath)
        let progress = imageApiClient.request(endpoint) { response in
            switch response {
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return progress
    }
    
    @discardableResult
    func getAvatar(avatarPath: String, _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress {
        let endpoint = AvatarEndpoint(baseURL: avatarBaseUrl, imagePath: avatarPath)
        let progress = imageApiClient.request(endpoint) { response in
            switch response {
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return progress
    }
}
