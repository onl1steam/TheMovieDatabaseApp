//
//  MovieDetailsEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Рыжков Артем on 16.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation

public class MovieDetailsEndpoint: Endpoint {

    public typealias Content = MovieDetailsResponse
    
    let baseURL: URL
    let apiKey: String
    let movieId: Int
    let language: String?
    
    public init(baseURL: URL, apiKey: String, movieId: Int, language: String?) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.movieId = movieId
        self.language = language
    }
    
    public func makeRequest() throws -> URLRequest {
        let queryItems = makeQueryItems()
        let url = makeURLPath()
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else { throw NetworkError.badURL }
        let request = URLRequest(url: resultURL)
        return request
    }
    
    public func content(from: Data?, response: URLResponse?) throws -> Content {
        guard let resp = response as? HTTPURLResponse else { throw NetworkError.unknownError }
        guard (200...300).contains(resp.statusCode) else {
            switch resp.statusCode {
            case 401:
                throw NetworkError.unauthorized
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.unknownError
            }
        }
        
        guard let data = from else { throw NetworkError.blankData }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let item = try decoder.decode(MovieDetailsResponse.self, from: data)
            return item
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func makeQueryItems() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        let apiKeyQuery = URLQueryItem(name: "api_key", value: apiKey)
        if let lang = language {
            let langQuery = URLQueryItem(name: "language", value: lang)
            queryItems.append(langQuery)
        }
        queryItems.append(apiKeyQuery)
        return queryItems
    }
    
    func makeURLPath() -> URL {
        var url = baseURL
        url.appendPathComponent("3")
        url.appendPathComponent("movie")
        url.appendPathComponent("\(movieId)")
        return url
    }
}
