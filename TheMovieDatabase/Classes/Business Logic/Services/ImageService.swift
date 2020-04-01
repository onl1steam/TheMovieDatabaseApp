//
//  ImageService.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 17.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit
import TheMovieDatabaseAPI

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
    
    // MARK: - Initializers
    
    init(imageApiClient: APIClient) {
        self.imageApiClient = imageApiClient
    }
    
    // MARK: - ImageServiceType
    
    @discardableResult
    func image(
        posterPath: String,
        width: String?,
        _ completion: @escaping (Result<UIImage, Error>) -> Void) -> Progress {
        let endpoint = ImageEndpoint(width: width, imagePath: posterPath)
        let progress = imageApiClient.request(endpoint, completionHandler: completion)
        return progress
    }
    
    @discardableResult
    func avatar(avatarPath: String, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> Progress {
        let endpoint = AvatarEndpoint(imagePath: avatarPath)
        let progress = imageApiClient.request(endpoint, completionHandler: completion)
        return progress
    }
}
