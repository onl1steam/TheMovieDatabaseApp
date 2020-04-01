//
//  ImageService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import TheMovieDatabaseAPI
import UIKit

protocol ImageServiceType {
    
    /// Загружает изображение постера фильма.
    ///
    /// - Parameters:
    ///   - posterPath: Путь до изображения.
    ///   - width: Ширина изображения в формате "w500". Если не указать, по умолчанию ставится значение "original".
    ///   - completion: Вызывается после выполнения функции. Возвращает ответом изображение в типе UIImage или ошибку.
    @discardableResult
    func image(posterPath: String, width: String?, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> Progress
    
    /// Загружает аватар пользователя.
    ///
    /// - Parameters:
    ///   - avatarPath: Путь до аватара.
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ изображение в типе UIImage или ошибку.
    @discardableResult
    func avatar(avatarPath: String, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> Progress
}

final class ImageService: ImageServiceType {
    
    // MARK: - Public Properties
    
    let imageBaseUrl = NetworkConfiguration.imageBaseURL
    let avatarBaseUrl = NetworkConfiguration.avatarBaseURL
    let imageApiClient: APIClient
    let imageCache: ImageCache
    
    // MARK: - Initializers
    
    init(imageApiClient: APIClient, imageCache: ImageCache = ImageCache()) {
        self.imageApiClient = imageApiClient
        self.imageCache = imageCache
    }
    
    // MARK: - ImageServiceType
    
    @discardableResult
    func image(
        posterPath: String,
        width: String?,
        _ completion: @escaping (Result<UIImage, Error>) -> Void) -> Progress {
        if let image = imageCache.checkImageInCache(key: posterPath) {
            completion(.success(image))
            return Progress()
        }
        let endpoint = ImageEndpoint(width: width, imagePath: posterPath)
        let progress = imageApiClient.request(endpoint) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let image):
                self.imageCache.cacheImage(key: posterPath, image: image)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return progress
    }
    
    @discardableResult
    func avatar(avatarPath: String, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> Progress {
        if let image = imageCache.checkImageInCache(key: avatarPath) {
            completion(.success(image))
            return Progress()
        }
        let endpoint = AvatarEndpoint(imagePath: avatarPath)
        let progress = imageApiClient.request(endpoint) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let image):
                self.imageCache.cacheImage(key: avatarPath, image: image)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return progress
    }
}
