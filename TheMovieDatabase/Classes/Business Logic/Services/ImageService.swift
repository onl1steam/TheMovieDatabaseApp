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
    
    /// Загружает изображение постера фильма.
    ///
    /// - Parameters:
    ///   - posterPath: Путь до изображения.
    ///   - width: Ширина изображения в формате "w500". Если не указать, по умолчанию ставится значение "original".
    ///   - completion: Вызывается после выполнения функции. Возвращает ответом изображение в типе Data или ошибку.
    @discardableResult
    func getImage(posterPath: String, width: String?, _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress
    
    /// Загружает аватар пользователя.
    ///
    /// - Parameters:
    ///   - avatarPath: Путь до аватара.
    ///   - completion: Вызывается после выполнения функции. Возвращает ответ изображение в типе Data или ошибку.
    @discardableResult
    func getAvatar(avatarPath: String, _ completion: @escaping (Result<Data, Error>) -> Void) -> Progress
}

class ImageService: ImageServiceType {
    
    // MARK: - Public Properties
    
    let imageBaseUrl = NetworkConfiguration.imageBaseURL
    let avatarBaseUrl = NetworkConfiguration.avatarBaseURL
    let imageApiClient: APIClient
    
    // MARK: - Initializers
    
    init(imageApiClient: APIClient = APIRequestImage()) {
        self.imageApiClient = imageApiClient
    }
    
    // MARK: - ImageServiceType
    
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
