//
//  APIRequestAdapter.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 27.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Alamofire
import Foundation

final class APIRequestAdapter: RequestAdapter {
    
    let configuration: Configuration
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        if let url = urlRequest.url, url.absoluteString.hasPrefix("t/p/original") {
            let requestUrl = URL(string: url.absoluteString, relativeTo: configuration.basePosterURL)!
            let request = makeRequest(from: urlRequest, with: requestUrl)
            completion(.success(request))
            return
        }
        
        if let url = urlRequest.url, url.absoluteString.hasPrefix("avatar") {
            let requestUrl = URL(string: url.absoluteString, relativeTo: configuration.baseAvatarURL)!
            let request = makeRequest(from: urlRequest, with: requestUrl)
            completion(.success(request))
            return
        }
        
        guard let urlString = urlRequest.url?.absoluteString,
            let url = URL(string: urlString, relativeTo: configuration.baseURL),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                completion(.failure(NetworkError.badURL))
                return
        }
        
        urlComponents.queryItems = makeQueryParameters(urlComponents: urlComponents)
        
        guard let requestUrl = urlComponents.url else {
                completion(.failure(NetworkError.badURL))
                return
        }
        
        let request = makeRequest(from: urlRequest, with: requestUrl)
        completion(.success(request))
    }
    
    private func makeRequest(from originalRequest: URLRequest, with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = originalRequest.allHTTPHeaderFields
        request.httpMethod = originalRequest.httpMethod
        request.httpBody = originalRequest.httpBody
        return request
    }
    
    private func makeQueryParameters(urlComponents: URLComponents) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        if var query = urlComponents.queryItems {
            query.append(URLQueryItem(name: "api_key", value: configuration.apiKey))
            queryItems = query
        } else {
            queryItems = [URLQueryItem(name: "api_key", value: configuration.apiKey)]
        }
        return queryItems
    }
}
